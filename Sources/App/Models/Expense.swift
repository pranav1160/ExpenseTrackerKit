//
//  Expense.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//

import Fluent
import Foundation

final class Expense: Model, @unchecked Sendable {
    // Define the schema name for the database table
    static let schema = "expenses"
    
    // Unique identifier for the model
    @ID(key: .id)
    var id: UUID?
    
    // Description of the expense (optional)
    @OptionalField(key: "description")
    var description: String?
    
    // Relationship to the category (required)
    @Parent(key: "category_id")
    var category: Category
    
    // Relationship to the account (required)
    @Parent(key: "account_id")
    var account: Account
    
    // Currency used for the expense (e.g., USD, EUR)
    @Field(key: "currency")
    var currency: String
    
    // Amount of the expense
    @Field(key: "amount")
    var amount: Int
    
    // Date of the expense
    @Field(key: "date")
    var date: Date
    
    // Default initializer required by Fluent
    init() { }
    
    // Custom initializer for creating an expense
    init(
        id: UUID? = nil,
        description: String? = nil,
        currency: String,
        amount: Int,
        date: Date,
        accountID: UUID,
        categoryID: UUID
    ) {
        self.id = id
        self.description = description
        self.currency = currency
        self.amount = amount
        self.date = date
        self.$account.id = accountID
        self.$category.id = categoryID
    }
}
