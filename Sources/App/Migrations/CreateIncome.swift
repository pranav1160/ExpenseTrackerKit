//
//  CreateIncome.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//


import Fluent

struct CreateIncome: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("incomes")
            .id()
            .field("categories_id", .uuid, .required, .references("categories", "id"))
            .field("amount" , .int , .required)
            .field("currency",.string,.required)
            .field("description",.string)
            .field("account_id", .uuid, .required, .references("accounts", "id"))
            .field("invoice_number",.string)
            .field("date_paid",.date,.required)
    
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("incomes").delete()
    }
}
