//
//  Purchase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Purchase {
    
    let price: Decimal
    let date: Date
    let category: String
    let comment: String
    
    init(_ price: Decimal, _ category: String, date: Date = Date.now, _ comment: String = "") {
        self.price = price
        self.date = date
        self.category = category
        self.comment = comment
    }
    
}
