//
//  CategoryDetailsViewModel.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

final class CategoryDetails { }

extension CategoryDetails {
    
    final class ViewModel : ObservableObject {
        
        @Published var category: Category
        @Published var purchases: [Purchase]
        let categoryPeriod: PlanningPeriod?
        private let storage: CentralStorage?
        
        init(_ category: Category) {
            self.storage = try? Di.inject(CentralStorage?.self)
            self.category = category
            self.purchases = (self.storage?.loadPurchases(for: category)) ?? [ ]
            self.categoryPeriod = self.storage?.loadPeriod(for: category)
        }
        
        func removeCategory() { storage?.removeCategory(category.id) }
        
        func getComment(for purchase: Purchase) -> String {
            if purchase.comment.isNotEmpty { return purchase.comment }
            else { return category.name }
        }
        
    }
    
}
