//
//  CategoryDetailsSummary.swift
//  treasury
//
//  Created by sugarbaron on 02.08.2021.
//

import SwiftUI

extension CategoryDetails {
    
    struct Summary : View {
        
        private let category: Category1
        
        init(_ category: Category1) {
            self.category = category
        }
        
        var body: some View {
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
