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
            self.storage = try? Di.inject(CentralStorage?.self)
            self.categories = [ ]
            let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
            let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
            self.categoriesUpdates = storage?.adjustSubscription(.init(sort:[expensiveFirst, abc]))
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
