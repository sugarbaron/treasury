//
//  Category.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Category {
    
    let name: String
    private(set) var plan: Decimal
    private(set) var spent: Decimal
    let planningPeriod: Int
    
    init(_ name: String, _ plan: Decimal, _ spent: Decimal, _ period: Int) {
        self.name = name
        self.plan = plan
        self.spent = spent
        self.planningPeriod = period
    }
    
    func purchase(_ price: Decimal) { spent += price }
    
    func deposit(_ amount: Decimal) { plan += amount }
    
}

extension Category : Identifiable { var id: String { name } }
