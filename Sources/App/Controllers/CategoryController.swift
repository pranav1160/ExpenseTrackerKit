//
//  CategoryController.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 11/02/25.
//


import Vapor

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.post(use: create)
        categories.put(use: update)
        
        categories.group(":id") { category in
            category.put(use: archive)
           
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [Category] {
        try await Category.query(on: req.db).all()
    }
    
    @Sendable
    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return category
    }
    
    @Sendable
    func update(req: Request) async throws -> Category {
        let updatedCategory = try req.content.decode(Category.self)
        
        guard let categoryFromDB = try await Category.find(updatedCategory.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        categoryFromDB.name = updatedCategory.name
        categoryFromDB.type = updatedCategory.type
        
        try await categoryFromDB.update(on: req.db)
        return categoryFromDB
    }

    
    
    @Sendable
    func archive(req: Request) async throws -> Category {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        category.isArchived=true
        try await category.update(on: req.db)
       
        return category
    }
    
}
