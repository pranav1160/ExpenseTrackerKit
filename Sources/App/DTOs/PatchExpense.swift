//
//  PatchExpense.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 13/02/25.
//
import Fluent
import Vapor

struct PatchExpense:Decodable{
    let id:UUID
    let description:String?
    let date:Date?
    let amount:Int?
    let accountID:UUID?
    let categoryID:UUID?
}
