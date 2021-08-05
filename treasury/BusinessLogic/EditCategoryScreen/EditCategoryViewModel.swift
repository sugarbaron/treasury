//
//  EditCategoryViewModel.swift
//  treasury
//
//  Created by sugarbaron on 02.08.2021.
//

import SwiftUI

final class EditCategory { }

extension EditCategory {
    
    final class ViewModel : ObservableObject {
        
        @Published var plan: String
        
        private let storage: CentralStorage?
        private let category: Category
        
        init(_ category: Category) {
            self.storage = try? Di.inject(CentralStorage?.self)
            self.plan = String("\(category.plan.int)")
            self.category = category
        }
        
        func editCategory() {
            guard let plan: Int = Int(self.plan) else { return }
            let editedCategory: Category = .init(category.name, Decimal(plan), category.spent, category.planningPeriod)
            storage?.save(editedCategory)
        }
        
    }
    
}
