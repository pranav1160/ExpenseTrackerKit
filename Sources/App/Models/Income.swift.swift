//
//  Income.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//

import Fluent
import Foundation
import Vapor

final class Income: Model,Content, @unchecked Sendable {
    // Define the schema name for the database table
    static let schema = "incomes"
    
    // Unique identifier for the model
    @ID(key: .id)
    var id: UUID?
    
    // Description of the income (optional)
    @OptionalField(key: "description")
    var description: String?
    
    // Relationship to the category (required)
    @Parent(key: "categories_id")
    var category: Category
    
    // Relationship to the account (required)
    @Parent(key: "account_id")
    var account: Account
    
    // Date of the invoice (optional)
    @OptionalField(key: "invoice_date")
    var invoiceDate: Date?
    
    // Currency used for the income (e.g., USD, EUR)
    @Field(key: "currency")
    var currency: String
    
    // Optional invoice number for the income
    @OptionalField(key: "invoice_number")
    var invoiceNumber: String?
    
    // Amount of the income
    @Field(key: "amount")
    var amount: Int
    
    // Date the income was paid
    @Field(key: "date_paid")
    var date_paid: Date
    
    // Default initializer required by Fluent
    init() { }
    
    // Custom initializer for creating an income
    init(
        id: UUID? = nil,
        description: String? = nil,
        currency: String,
        amount: Int,
        date_paid: Date,
        accountID: UUID,
        categoryID: UUID,
        invoiceNumber: String? = nil,
        invoiceDate: Date? = nil
    ) {
        self.id = id
        self.description = description
        self.currency = currency
        self.amount = amount
        self.date_paid = date_paid
        self.invoiceNumber = invoiceNumber
        self.$account.id = accountID
        self.$category.id = categoryID
        self.invoiceDate = invoiceDate
    }
}
