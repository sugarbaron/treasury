//
//  CategoryCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import Foundation

extension CoreDataCategory {
    
    func fill(with category: Category) {
        self.name = category.name
        self.plan = category.plan.nsDecimal
        self.fact = category.spent.nsDecimal
    }
    
}

extension Category : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataCategory) -> Category? {
        guard let name: String = coreDataEntity.name,
              let plan: NSDecimalNumber = coreDataEntity.plan,
              let fact: NSDecimalNumber = coreDataEntity.fact
        else { return nil }
        return .init(name, plan.decimalValue, fact.decimalValue)
    }
    
}
