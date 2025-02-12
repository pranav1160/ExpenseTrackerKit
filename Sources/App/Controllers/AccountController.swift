//
//  AccountController.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 11/02/25.
//
import Vapor

struct AccountsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let accounts = routes.grouped("accounts")
        accounts.get(use: index)
        accounts.post(use: create)
        
        accounts.group(":id") { account in
//            account.get(use: show)
            account.put(use: update)
            account.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [Account] {
        try await Account.query(on: req.db).all()
    }
    
    @Sendable
    func create(req: Request) async throws -> Account {
        let account = try req.content.decode(Account.self)
        try await account.save(on: req.db)
        return account
    }
    

    
    @Sendable
    func update(req: Request) async throws -> Account {
        guard let account = try await Account.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedAccount = try req.content.decode(Account.self)
        account.name = updatedAccount.name
        try await account.update(on: req.db)
        return account
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let account = try await Account.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await account.delete(on: req.db)
        return .ok
    }
    
}
