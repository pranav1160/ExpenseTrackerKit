//
//  CreateCategory.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 09/02/25.
//

import Fluent

struct CreateCategory: AsyncMigration {
    func prepare(on database: Database) async throws {
        let categoryType = try await database.enum("category_type").read()
        
        try await database.schema("categories")
            .id()
            .field("name", .string, .required)
            .field("isArchived",.bool,.required)
            .field("category_type", categoryType)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }
}
