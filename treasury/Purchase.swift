//
//  Purchase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Purchase {
    
    let price: Decimal
    let category: String
    let name: String?
    
    init(_ price: Decimal, _ category: String, _ name: String? = nil) {
        self.price = price
        self.category = category
        self.name = name
    }
    
}
