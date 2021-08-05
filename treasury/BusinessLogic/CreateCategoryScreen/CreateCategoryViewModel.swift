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
        @Published var fact: String
        
        init() {
            self.name = ""
            self.plan = ""
            self.fact = ""
        }
        
        func createCategory() {
            guard let storage: CentralStorage = try? Di.inject(CentralStorage?.self),
                  name.isNotEmpty,
                  let plan: Int = Int(self.plan),
                  let currentPeriod: PlanningPeriod = storage.loadCurrentPeriod()
            else { Log(error: "[CreateCategory.ViewModel] unable to create category"); return }
            let fact: Int = Int(self.fact) ?? 0
            Log(info: "[CreateCategory.ViewModel] new category for period:[\(currentPeriod.id) \(currentPeriod.start.format()) \(currentPeriod.end.format())]") /* fixme */
            let newCategory: Category = .init(name, Decimal(plan), Decimal(fact), currentPeriod.id)
            storage.save(newCategory)
        }
        
    }
    
}
