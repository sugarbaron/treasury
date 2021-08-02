//
//  CategoryDetailsViewModel.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

extension CategoryDetails {
    
    final class ViewModel : ObservableObject {
        
        @Published var category: Category
        @Published var purshases: [Purchase]
        private let storage: CentralStorage?
        
        init(_ category: Category) {
            self.storage = try? Di.inject(CentralStorage?.self)
            self.category = category
            self.purshases = (self.storage?.loadPurchases(for: category)) ?? [ ]
        }
        
        func removeCategory() { storage?.removeCategory(category.name) }
        
    }
    
}
