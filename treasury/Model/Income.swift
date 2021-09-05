//
//  Income.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import Foundation

final class Income {
    
    let id: Int
    let amount: Decimal
    let date: Date
    let comment: String?
    
    init(_ id: Int, _ amount: Decimal, _ date: Date, _ comment: String?) {
        self.id = id
        self.amount = amount
        self.date = date
        self.comment = comment
    }
    
}

extension Income {
    
    final class Draft {
        
        let amount: Decimal
        let date: Date
        let comment: String?
        
        init(_ amount: Decimal, _ date: Date, _ comment: String?) {
            self.amount = amount
            self.date = date
            self.comment = comment
        }
        
    }
    
    convenience init(_ id: Int, _ draft: Draft) {
        self.init(id, draft.amount, draft.date, draft.comment)
    }
    
}
