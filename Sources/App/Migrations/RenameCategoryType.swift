//
//  File.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 12/02/25.
//

import Foundation

import Fluent

struct RenameCategoryType: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("categories")
            .deleteField("type")
            .field("category_type", .string, .required)
            .update()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("categories")
            .deleteField("type")
            .field("category_type", .string, .required)
            .update()
    }
}
