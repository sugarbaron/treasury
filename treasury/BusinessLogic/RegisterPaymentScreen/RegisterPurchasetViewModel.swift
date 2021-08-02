//
//  RegisterPurchaseViewModel.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

extension RegisterPurchase {
    
    final class ViewModel : ObservableObject {
        
        @Published var category: String
        @Published var price: String
        @Published var comment: String
        private let categories: [Category]
        
        private let storage: CentralStorage?
        
        init() {
            self.category = ""
            self.price = ""
            self.comment = ""
            self.storage = try? Di.inject(CentralStorage?.self)
            self.categories = storage?.loadAllCategories() ?? [ ]
        }
        
        private func loadCategories() -> [String] {
            let categories: [Category] = storage?.loadAllCategories() ?? [ ]
            return categories.map { $0.name }
        }
        
        var categoriesList: [String] { categories.map { $0.name } }
        
        func registerPayment() {
            guard let price: Int = Int(self.price),
                  let category: Category = categories.first(where: { $0.name == category })
            else { return }
            let purchase: Purchase = .init(Decimal(price), category.name, comment)
            category.purchase(Decimal(price))
            storage?.save(category)
            storage?.save(purchase)
        }
        
    }
    
}
