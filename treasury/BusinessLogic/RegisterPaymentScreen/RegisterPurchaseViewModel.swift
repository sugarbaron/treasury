//
//  RegisterPurchaseViewModel.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

final class RegisterPurchase { }

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
            self.categories = storage?.loadCurrentPeriodCategories() ?? [ ]
        }
        
        var categoriesList: [String] { categories.map { $0.name } }
        
        func registerPayment() {
            guard let price: Int = Int(self.price),
                  let category: Category = categories.first(where: { $0.name == category })
            else { return }
            let purchaseDraft: Purchase.Draft = .init(Decimal(price), category.id, comment)
            category.purchase(Decimal(price))
            storage?.update(category)
            storage?.create(from: purchaseDraft)
        }
        
    }
    
}
