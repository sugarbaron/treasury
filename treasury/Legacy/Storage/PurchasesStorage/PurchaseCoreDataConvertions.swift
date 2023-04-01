//
//  PurchaseCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import Foundation

extension CoreDataPurchase {
    
    func fill(with purchase: Purchase1) {
        self.id = NSNumber(value: purchase.id)
        self.price = purchase.price.nsDecimal
        self.category = NSNumber(value: purchase.category)
        self.date = purchase.date
        self.comment = purchase.comment
    }
    
}

extension Purchase1 : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataPurchase) -> Purchase1? {
        guard let id: Int = coreDataEntity.id?.intValue,
              let price: Decimal = coreDataEntity.price?.decimalValue,
              let category: Int = coreDataEntity.category?.intValue,
              let date: Date = coreDataEntity.date
        else { return nil }
        return .init(id, price, category, date: date, coreDataEntity.comment ?? "")
    }
    
}
