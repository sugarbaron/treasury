//
//  Purchase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

final class Purchase {
    
    let id: Int
    let price: Decimal
    let date: Date
    let category: Int
    let comment: String
    
    init(_ id: Int, _ price: Decimal, _ category: Int, date: Date = Date.now, _ comment: String = "") {
        self.id = id
        self.price = price
        self.date = date
        self.category = category
        self.comment = comment
    }
    
}

extension Purchase {
    
    final class Draft {
        
        let price: Decimal
        let date: Date
        let category: Int
        let comment: String
        
        init(_ price: Decimal, _ category: Int, date: Date = Date.now, _ comment: String = "") {
            self.price = price
            self.date = date
            self.category = category
            self.comment = comment
        }
        
    }
    
    convenience init(_ id: Int, _ draft: Draft) {
        self.init(id, draft.price, draft.category, date: draft.date, draft.comment)
    }
    
}

extension Purchase : Identifiable { }

extension Purchase : Equatable {
    
    static func == (lhs: Purchase, rhs: Purchase) -> Bool {
        lhs.id == rhs.id
            && lhs.price == rhs.price
            && lhs.date == rhs.date
            && lhs.category == rhs.category
            && lhs.comment == rhs.comment
    }
    
}
