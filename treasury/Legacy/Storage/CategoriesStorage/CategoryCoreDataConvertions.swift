//
//  CategoryCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import Foundation

extension CoreDataCategory {
    
    func fill(with category: Category1) {
        self.id = NSNumber(value: category.id)
        self.name = category.name
        self.plan = category.plan.nsDecimal
        self.fact = category.spent.nsDecimal
        self.periodId = NSNumber(value: category.planningPeriod)
    }
    
}

extension Category1 : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataCategory) -> Category1? {
        guard let id: Int = coreDataEntity.id?.intValue,
              let name: String = coreDataEntity.name,
              let plan: NSDecimalNumber = coreDataEntity.plan,
              let fact: NSDecimalNumber = coreDataEntity.fact,
              let periodId: Int = coreDataEntity.periodId?.intValue
        else { return nil }
        return .init(id, name, plan.decimalValue, fact.decimalValue, periodId)
    }
    
}
