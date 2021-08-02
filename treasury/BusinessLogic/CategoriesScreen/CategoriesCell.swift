//
//  CategoriesCell.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

extension Categories {
    
    struct Cell : View {
        
        @State private var isTapped: Bool
        private let category: Category
        
        init(_ category: Category) { self.category = category; self.isTapped = false }
        
        var body: some View {
            CategoryCard(category)
                .fullScreenCover(isPresented: $isTapped ) { CategoryDetails.Screen(category) }
                .onTapGesture { isTapped.toggle() }
        }
        
    }
    
}

extension Categories.Cell : Identifiable {
    
    var id: String { category.name }
    
}
