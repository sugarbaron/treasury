//
//  CategoriesViewModel.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import SwiftUI

final class Categories { }

extension Categories {
    
    final class ViewModel : ObservableObject {
        
        @Published var categories: [Category]
        
        private let storage: CentralStorage?
        private let categoriesUpdates: Storage.Updates<ViewModel>?
        
        init() {
            let storage: CentralStorage? = try? Di.inject(CentralStorage?.self)
            self.storage = storage
            self.categories = [ ]
            guard let currentPeriod: PlanningPeriod = storage?.loadCurrentPeriod()
            else {
                self.categoriesUpdates = nil
                Log(error: "[Categories.ViewModel] unable to load current period")
                return
            }
            let ofCurrentPeriod: NSPredicate = .init(format: "\(CategoryFields.periodId) == \(currentPeriod.id)")
            let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
            let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
            self.categoriesUpdates = storage?.adjustSubscription(.init(ofCurrentPeriod, sort:[expensiveFirst, abc]))
            if let updates: Storage.Updates<ViewModel> = categoriesUpdates {
                subscribe(to: updates)
                self.categories = updates.updatedContent?.entities ?? [ ]
            }
        }
        
        var currentPeriod: PlanningPeriod? { storage?.loadCurrentPeriod() }
        
    }

}

extension Categories.ViewModel : StorageSubscriber {
    
    func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<Category>) {
        categories = updatedContent.entities
    }
    
}
