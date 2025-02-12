//
//  PatchIncome.swift
//  ExpenseTrackerKit
//
//  Created by Pranav on 13/02/25.
//

import Fluent
import Vapor

struct PatchIncome:Decodable{
    let id:UUID
    let description:String?
    let datePaid:Date?
    let amount:Int?
    let accountID:UUID?
    let categoryID:UUID?
    let invoiceNumber:String?
    let invoiceDate:Date?
}
