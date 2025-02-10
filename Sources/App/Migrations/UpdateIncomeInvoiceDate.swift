//
//  UpdateIncomeInvoiceDate.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//
import Fluent

struct UpdateIncomeInvoiceDate: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("incomes")
            .field("invoice_date",.date)
            .update()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("incomes")
            .deleteField("invoice_date")
            .update()
    }
}
