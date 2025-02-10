//
//  CreateCategoryType.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 09/02/25.
//

import Fluent

struct CreateCategoryType: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.enum("category_type")
            .case("income")
            .case("expense")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.enum("category_type").delete()
    }
}
