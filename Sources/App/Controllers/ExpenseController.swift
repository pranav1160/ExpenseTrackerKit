//
//  ExpenseController.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 12/02/25.
//


import Vapor



struct ExpenseController: RouteCollection {
   
    func boot(routes: RoutesBuilder) throws {
        let expenses = routes.grouped("expenses")
        expenses.get(use: index)
        expenses.post(use: create)
        expenses.patch(use: update)
        
        expenses.group(":id") { expense in
                // Move the PUT route here
            expense.delete(use: delete)
        }
    }
    
    
    @Sendable
    func index(req: Request) async throws -> [Expense] {
        try await Expense.query(on: req.db).all()
    }
    
    
    @Sendable
    func create(req: Request) async throws -> Expense {
        let expense = try req.content.decode(Expense.self)
        try await expense.save(on: req.db)
        return expense
    }
    
 
   
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let expense = try await Expense.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await expense.delete(on: req.db)
        return .ok
    }
    
    
    @Sendable
    func update(req: Request) async throws -> Expense {
        let updatedExpense = try req.content.decode(PatchExpense.self)
        
        guard let expense = try await Expense.find(updatedExpense.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        if let description = updatedExpense.description{
            expense.description = description
        }
        
        if let date = updatedExpense.date{
            expense.date = date
        }
        
        if let amount = updatedExpense.amount{
            expense.amount = amount
        }
        
        if let accountID = updatedExpense.accountID{
            expense.$account.id = accountID
        }
        
        if let categoryID = updatedExpense.categoryID{
            expense.$category.id = categoryID
        }
        
        try await expense.update(on: req.db)
        return expense
    }
    
    
}
