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
            self.currentPeriodSubscriber = .init() { [weak self] period in
                guard let this = self, period.isDifferent(than: this.currentPeriod) else { return }
                self?.currentPeriod = period
                
                let ofCurrentPeriod: NSPredicate = .init(format: "\(CategoryFields.periodId) == \(period.id)")
                let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
                let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
                let config: Storage.SubscriptionConfig = .init(ofCurrentPeriod, sort:[expensiveFirst, abc])
                this.categoriesUpdates = this.storage?.adjustSubscription(config)
                if let updates: Storage.Updates<ViewModel> = this.categoriesUpdates {
                    this.subscribe(to: updates)
                    this.categories = updates.updatedContent?.entities ?? [ ]
                }
            }
        }
        
    }

}

extension Categories.ViewModel : StorageSubscriber {
    
    func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<Category>) {
        Threads.runOnMain { [weak self] in self?.categories = updatedContent.entities }
    }
    
}

extension Categories {
    
    final class CurrentPeriodSubscriber : StorageSubscriber {
        
        private let onUpdate: (PlanningPeriod) -> Void
        private let storage: CentralStorage
        private let storageUpdates: StorageUpdates
        
        init?(_ onUpdate: @escaping (PlanningPeriod) -> Void) {
            guard let storage: CentralStorage = try? Di.inject(CentralStorage?.self)
            else { Log(error: "[CurrentPeriodSubscriber] unable to construct"); return nil }
            
            self.storage = storage
            self.onUpdate = onUpdate
            let descendingIds: NSSortDescriptor = .init(key: PlanningPeriodFields.id, ascending: false)
            let updates: StorageUpdates = storage.adjustSubscription(.init(sort: [descendingIds]))
            self.storageUpdates = updates
            subscribe(to: updates)
            Threads.runOnMain { [weak self] in
                guard let period: PlanningPeriod = self?.storageUpdates.updatedContent?.entities.first else { return }
                self?.onUpdate(period)
            }
        }
        
        func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<PlanningPeriod>) {
            Threads.runOnMain { [weak self] in
                guard let period: PlanningPeriod = updatedContent.entities.first else { return }
                self?.onUpdate(period)
            }
        }
        
        private typealias StorageUpdates = Storage.Updates<CurrentPeriodSubscriber>
        
    }
    
}
