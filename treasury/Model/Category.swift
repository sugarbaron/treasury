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
    
    init(_ name: String, _ plan: Decimal, _ spent: Decimal) {
        self.name = name
        self.plan = plan
        self.spent = spent
    }
    
    func purchase(_ price: Decimal) { spent += price }
    
    func deposit(_ amount: Decimal) { plan += amount }
    
}

extension Category : Identifiable { var id: String { name } }
