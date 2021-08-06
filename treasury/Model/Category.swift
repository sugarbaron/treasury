//
//  Category.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Category {
    
    let id: Int
    private(set) var name: String
    private(set) var plan: Decimal
    private(set) var spent: Decimal
    let planningPeriod: Int
    
    init(_ id: Int, _ name: String, _ plan: Decimal, _ spent: Decimal, _ period: Int) {
        self.id = id
        self.name = name
        self.plan = plan
        self.spent = spent
        self.planningPeriod = period
    }
    
    func purchase(_ price: Decimal) { spent += price }
    
    func deposit(_ amount: Decimal) { plan += amount }
    
    func rename(_ name: String) { self.name = name }
    
}

extension Category {
    
    final class Draft {
        
        let name: String
        let plan: Decimal
        let spent: Decimal
        let planningPeriod: Int
        
        init(_ name: String, _ plan: Decimal, _ spent: Decimal, _ period: Int) {
            self.name = name
            self.plan = plan
            self.spent = spent
            self.planningPeriod = period
        }
        
    }
    
    convenience init(_ id: Int, _ draft: Draft) {
        self.init(id, draft.name, draft.plan, draft.spent, draft.planningPeriod)
    }
    
}

extension Category : Identifiable {  }
