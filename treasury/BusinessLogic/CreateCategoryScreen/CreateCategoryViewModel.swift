//
//  CategoriesCreateViewModel.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import SwiftUI

extension CreateCategory {
    
    final class ViewModel : ObservableObject {
        
        @State var name: String
        @State var plan: String
        @State var fact: String
        
        init() {
            self.name = ""
            self.plan = ""
            self.fact = ""
        }
        
    }
    
}
