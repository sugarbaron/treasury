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
        
        @Published var currentPeriod: PlanningPeriod?
        
        private let storage: CentralStorage?
        private var categoriesUpdates: Storage.Updates<ViewModel>?
        private var currentPeriodSubscriber: CurrentPeriodSubscriber?
        
        init() {
            let storage: CentralStorage? = try? Di.inject(CentralStorage?.self)
            self.storage = storage
            self.categories = [ ]
            self.currentPeriodSubscriber = nil
            self.currentPeriod = nil
            self.categoriesUpdates = nil
            self.currentPeriodSubscriber = .init() { [weak self] period in self?.currentPeriod = period }
            guard let currentPeriod: PlanningPeriod = self.currentPeriod else { return }
            
            let ofCurrentPeriod: NSPredicate = .init(format: "\(CategoryFields.periodId) == \(currentPeriod.id)")
            let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
            let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
            self.categoriesUpdates = storage?.adjustSubscription(.init(ofCurrentPeriod, sort:[expensiveFirst, abc]))
            if let updates: Storage.Updates<ViewModel> = categoriesUpdates {
                subscribe(to: updates)
                self.categories = updates.updatedContent?.entities ?? [ ]
            }
        }
        
    }

}

extension Categories.ViewModel : StorageSubscriber {
    
    func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<Category>) {
        categories = updatedContent.entities
    }
    
}

extension Categories {
    
    final class CurrentPeriodSubscriber : StorageSubscriber {
        
        private let onUpdate: (PlanningPeriod?) -> Void
        private let storage: CentralStorage
        private let storageUpdates: StorageUpdates
        
        init?(_ onUpdate: @escaping (PlanningPeriod?) -> Void) {
            guard let storage: CentralStorage = try? Di.inject(CentralStorage?.self)
            else { Log(error: "[CurrentPeriodSubscriber] unable to construct"); return nil }
            
            self.storage = storage
            self.onUpdate = onUpdate
            let descendingIds: NSSortDescriptor = .init(key: PlanningPeriodFields.id, ascending: false)
            let updates: StorageUpdates = storage.adjustSubscription(.init(sort: [descendingIds]))
            self.storageUpdates = updates
            subscribe(to: updates)
            onUpdate(storageUpdates.updatedContent?.entities.first)
        }
        
        func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<PlanningPeriod>) {
            onUpdate(updatedContent.entities.first)
        }
        
        private typealias StorageUpdates = Storage.Updates<CurrentPeriodSubscriber>
        
    }
    
}
