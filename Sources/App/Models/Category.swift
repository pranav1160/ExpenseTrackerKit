//
//  Category.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//
import Fluent
import struct Foundation.UUID
import Vapor

enum CategoryType: String, Codable {
    case income, expense
}

final class Category: Model,Content, @unchecked Sendable {
    static let schema = "categories"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "isArchived")
    var isArchived:Bool
    
    @Enum(key: "category_type")
    var type: CategoryType
    
    
    init() { }
    
    init(id: UUID? = nil, name: String , isArchived:Bool ,type:CategoryType) {
        self.id = id
        self.name = name
        self.isArchived = isArchived
        self.type = type
    }
    
}

