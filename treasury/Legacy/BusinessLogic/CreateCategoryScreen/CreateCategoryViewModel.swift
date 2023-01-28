//
//  CategoriesCreateViewModel.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import SwiftUI

final class CreateCategory {  }

extension CreateCategory {
    
    final class ViewModel : ObservableObject {
        
        @Published var name: String
        @Published var plan: String
        
        init() {
            self.name = ""
            self.plan = ""
        }
        
        func createCategory() {
            let storage: CentralStorage? = try? Di.inject(CentralStorage?.self)
            guard let categoriesStorage: CategoriesStorage = storage?.categories,
                  name.isNotEmpty,
                  let plan: Int = Int(self.plan),
                  let currentPeriod: PlanningPeriod = storage?.periods.loadCurrentPeriod()
            else { Log(error: "[CreateCategory.ViewModel] unable to create category"); return }
            
            let newCategoryDraft: Category.Draft = .init(name, Decimal(plan), Decimal(0), currentPeriod.id)
            categoriesStorage.create(from: newCategoryDraft)
        }
        
    }
    
}
