//
//  CategoriesViewModel.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import SwiftUI

extension Categories {
    
    final class ViewModel : ObservableObject {
        
        @Published var categories: [Category]
        
        private let storage: CentralStorage?
        
        init() {
            if let storage: CentralStorage = try? Di.inject(CentralStorage?.self) {
                self.storage = storage
                self.categories = storage.loadAllCategories()
            } else {
                Log(error: "[Categories.ViewModel] unable to construct")
                self.storage = nil
                self.categories = [ ]
            }
        }
        
    }

}
