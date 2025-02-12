//
//  IncomeController.swift
//  IncomeTrackerKit
//
//  Created by Pranav on 12/02/25.
//


import Vapor



struct IncomeController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let Incomes = routes.grouped("incomes")
        Incomes.get(use: index)
        Incomes.post(use: create)
        Incomes.patch(use: update)
        
        Incomes.group(":id") { Income in
            // Move the PUT route here
            Income.delete(use: delete)
        }
    }
    
    
    @Sendable
    func index(req: Request) async throws -> [Income] {
        try await Income.query(on: req.db).all()
    }
    
    
    @Sendable
    func create(req: Request) async throws -> Income {
        let Income = try req.content.decode(Income.self)
        try await Income.save(on: req.db)
        return Income
    }
    
    
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let Income = try await Income.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await Income.delete(on: req.db)
        return .ok
    }
    
    
    @Sendable
    func update(req: Request) async throws -> Income {
        let updatedIncome = try req.content.decode(PatchIncome.self)
        
        guard let incomeDB = try await Income.find(updatedIncome.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        if let description = updatedIncome.description{
            incomeDB.description = description
        }
        
        if let date = updatedIncome.datePaid{
            incomeDB.date_paid = date
        }
        
        if let amount = updatedIncome.amount{
            incomeDB.amount = amount
        }
        
        if let accountID = updatedIncome.accountID{
            incomeDB.$account.id = accountID
        }
        
        if let categoryID = updatedIncome.categoryID{
            incomeDB.$category.id = categoryID
        }
        
        if let invoiceNumber = updatedIncome.invoiceNumber{
            incomeDB.invoiceNumber=invoiceNumber
        }
        
        if let invoiceDate = updatedIncome.invoiceDate{
            incomeDB.invoiceDate = invoiceDate
        }

        
        try await incomeDB.update(on: req.db)
        return incomeDB
    }
    
    
}
