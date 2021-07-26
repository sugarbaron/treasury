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
    
    init(_ name: String, _ plan: Decimal, _ fact: Decimal) {
        self.name = name
        self.plan = plan
        self.fact = fact
    }
    
    func purchase(_ purchase: Purchase) { fact -= purchase.price }
    
    func deposit(_ amount: Decimal) { plan += amount }
    
}

extension Category : Identifiable { var id: String { name } }
