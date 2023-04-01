//
//  Plan.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

import Foundation

final class Plan {
    
    let from: Date
    let till: Date
    let categories: [CategoryPlan]
    
    init(from: Date, till: Date, categories: [CategoryPlan]) {
        self.from = from
        self.till = till
        self.categories = categories
    }
    
}

final class CategoryPlan {
    
    let categoryId: Int
    let amount: Int
    
    init(categoryId: Int, amount: Int) {
        self.categoryId = categoryId
        self.amount = amount
    }
    
}
