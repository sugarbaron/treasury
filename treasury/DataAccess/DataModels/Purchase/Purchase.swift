//
//  Purchase.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

import Foundation

final class Purchase {
    
    let id: Int
    let price: Int
    let date: Date
    let categoryId: Int
    let comment: String
    
    init(id: Int, price: Int, date: Date, categoryId: Int, comment: String) {
        self.id = id
        self.price = price
        self.date = date
        self.categoryId = categoryId
        self.comment = comment
    }
    
}

extension Purchase {
    
    final class Draft {
        
        let price: Int
        let date: Date
        let categoryId: Int
        let comment: String
        
        init(price: Int, date: Date, categoryId: Int, comment: String) {
            self.price = price
            self.date = date
            self.categoryId = categoryId
            self.comment = comment
        }
        
    }
    
}
