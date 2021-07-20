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
    private(set) var fact: Decimal
    private(set) var history: [Purchase]
    
    init(_ name: String, _ plan: Decimal, _ fact: Decimal) {
        self.name = name
        self.plan = plan
        self.fact = fact
        self.history = [ ]
    }
    
    func purchase(_ price: Decimal, _ name: String? = nil) {
        fact -= price
        history += Purchase(price, self.name, name)
    }
    
    func deposit(_ amount: Decimal) { plan += amount }
    
}
