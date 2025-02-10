//
//  Income.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//

import Fluent
import Foundation

final class Income: Model, @unchecked Sendable {
    // Define the schema name for the database table
    static let schema = "incomes"
    
    // Unique identifier for the model
    @ID(key: .id)
    var id: UUID?
    
    // Description of the income (optional)
    @OptionalField(key: "description")
    var description: String?
    
    // Relationship to the category (required)
    @Parent(key: "category_id")
    var category: Category
    
    // Relationship to the account (required)
    @Parent(key: "account_id")
    var account: Account
    
    // Currency used for the income (e.g., USD, EUR)
    @Field(key: "currency")
    var currency: String
    
    // Optional invoice number for the income
    @OptionalField(key: "invoice_number")
    var invoice: String?
    
    // Amount of the income
    @Field(key: "amount")
    var amount: Int
    
    // Date the income was paid
    @Field(key: "date_paid")
    var date: Date
    
    // Default initializer required by Fluent
    init() { }
    
    // Custom initializer for creating an income
    init(
        id: UUID? = nil,
        description: String? = nil,
        currency: String,
        amount: Int,
        date: Date,
        accountID: UUID,
        categoryID: UUID,
        invoice: String? = nil
    ) {
        self.id = id
        self.description = description
        self.currency = currency
        self.amount = amount
        self.date = date
        self.invoice = invoice
        self.$account.id = accountID
        self.$category.id = categoryID
    }
}
