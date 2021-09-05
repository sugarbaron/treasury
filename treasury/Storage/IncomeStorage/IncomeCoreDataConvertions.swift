//
//  IncomeCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import Foundation

extension Income : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataIncome) -> Income? {
        guard let id: Int = coreDataEntity.id?.intValue,
              let amount: Decimal = coreDataEntity.amount?.decimalValue,
              let date: Date = coreDataEntity.date
        else { Log(error: "[Income] unable to construct from coreDataEntity"); return nil }
        
        return .init(id, amount, date, coreDataEntity.comment)
    }
    
}

extension CoreDataIncome {
    
    func fill(with income: Income) {
        self.id = NSNumber(value: income.id)
        self.amount = income.amount.nsDecimal
        self.date = income.date
        self.comment = income.comment
    }
    
}
