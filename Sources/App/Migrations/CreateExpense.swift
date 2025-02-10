//
//  CreateExpense.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//

import Fluent

struct CreateExpenses: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("expenses")
            .id()
            .field("categories_id", .uuid, .required, .references("categories", "id"))
            .field("amount" , .int , .required)
            .field("currency",.string,.required)
            .field("date",.date,.required)
            .field("description",.string)
            .field("account_id", .uuid, .required, .references("accounts", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("expenses").delete()
    }
}
