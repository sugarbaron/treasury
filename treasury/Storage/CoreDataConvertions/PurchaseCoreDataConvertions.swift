//
//  PurchaseCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import Foundation

extension CoreDataPurchase {
    
    func fill(with purchase: Purchase) {
        self.price = purchase.price.nsDecimal
        self.category = purchase.category
        self.date = purchase.date
        self.comment = purchase.comment
    }
    
}

extension Purchase : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataPurchase) -> Purchase? {
        guard let price: Decimal = coreDataEntity.price?.decimalValue,
              let category: String = coreDataEntity.category,
              let date: Date = coreDataEntity.date
        else { return nil }
        return .init(price, category, date: date, coreDataEntity.comment ?? "")
    }
    
}
