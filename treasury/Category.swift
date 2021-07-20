//
//  Category.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Category {
    
    let name: String
    let plan: Decimal
    var fact: Decimal
    
    init(_ name: String, _ plan: Decimal, _ fact: Decimal) {
        self.name = name
        self.plan = plan
        self.fact = fact
    }
    
    func purchase(_ price: Decimal, _ name: String? = nil) {
        fact = fact - price
    }
    
}
