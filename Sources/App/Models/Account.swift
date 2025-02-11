//
//  Account.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 10/02/25.
//

import Fluent
import Vapor


final class Account: Model,Content, @unchecked Sendable {
    static let schema = "accounts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
 
}
