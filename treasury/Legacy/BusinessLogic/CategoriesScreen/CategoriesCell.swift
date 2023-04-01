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
        private let category: Category1
        
        init(_ category: Category1) { self.category = category; self.isTapped = false }
        
        var body: some View {
            VStack {
                Text(category.name).font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Colors.gray)
                    .foregroundColor(Colors.black)
                    .cornerRadius(5)
                HStack {
                    AmountCard("limit:", category.plan.int)
                        .frame(maxWidth: .infinity)
                        .background(Colors.biege)
                        .cornerRadius(5)
                    AmountCard("spent:", category.spent.int)
                        .frame(maxWidth: .infinity)
                        .background(Colors.biege)
                        .cornerRadius(5)
                    AmountCard("available:", category.plan.int - category.spent.int)
                        .frame(maxWidth: .infinity)
                        .background(warningColor)
                        .cornerRadius(5)
                }
                .frame(maxWidth: .infinity)
                .fullScreenCover(isPresented: $isTapped ) { CategoryDetails.Screen(category) }
                .onTapGesture { isTapped.toggle() }
            }
        }
        
        private var warningColor: Color {
            switch (Double(category.spent.int) / Double(category.plan.int)) {
            case let ratio where ratio < 0.25: return Colors.green
            case let ratio where ratio > 0.75: return Colors.red
            default:                           return Colors.biege
            }
        }
        
    }
    
}

extension Categories.Cell : Identifiable {
    
    var id: String { category.name }
    
}
