//
//  PurchaseFields.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

extension CoreDataPurchase : CoreDataEntity { public static let entityName: String = "Purchase" }

final class PurchaseFields {
    
    static let price: String = "price"
    static let date: String = "date"
    static let category: String = "category"
    static let comment: String = "comment"
    
}
