//
//  RegisterPurchaseViewModel.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

final class RegisterPurchase1 { }

extension RegisterPurchase1 {
    
    final class ViewModel : ObservableObject {
        
        @Published var category: String
        @Published var price: String
        @Published var comment: String
        private let categories: [Category]
        private(set) var mode: Mode
        
        private let storage: CentralStorage?
        
        init(_ category: Category? = nil) {
            self.category = unwrap(category) { $0.name } ?? ""
            self.price = ""
            self.comment = ""
            self.storage = try? Di.inject(CentralStorage?.self)
            self.categories = storage?.categories.loadCurrentPeriodCategories() ?? [ ]
            self.mode = category == nil ? .currentPeriodCategories : .certainCategory
        }
        
        var categoriesList: [String] { categories.map { $0.name } }
        
        func registerPayment() {
            guard let price: Int = Int(self.price),
                  let category: Category = categories.first(where: { $0.name == category })
            else { return }
            let purchaseDraft: Purchase.Draft = .init(Decimal(price), category.id, comment)
            category.purchase(Decimal(price))
            storage?.categories.update(category)
            storage?.purchases.create(from: purchaseDraft)
        }
        
    }
    
}

extension RegisterPurchase1.ViewModel {
    
    enum Mode { case certainCategory; case currentPeriodCategories }
    
}
