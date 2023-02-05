//
//  CategoriesScreen.swift
//  treasury
//
//  Created by sugarbaron on 22.07.2021.
//

import SwiftUI

// MARK: Screen

extension Categories {

    struct Screen : View {
        
        @ObservedObject private var viewModel: ViewModel = .init()
        
        @State private var isCreatePressed: Bool = false
        @State private var isEditPressed: Bool = false
        @State private var isPurchaseTapped: Bool = false
        
        var body: some View {
            HStack {
                Layout1.xSpace
                VStack {
                    Layout1.ySpace
                    titlePanel
                    Layout1.ySpace
                    periodPanel
                    ScrollView { ForEach(viewModel.categories) { category in Cell(category) } }
                    Layout1.ySpace
                    if (viewModel.categories.isNotEmpty) { footerPanel }
                    Layout1.ySpace
                }
                Layout1.xSpace
            }
            .background(Colors.background)
            .frame(maxWidth: .infinity)
        }
        
        private var titlePanel: some View {
            HStack(alignment: .top) {
                EditPeriodButton()
                    .fullScreenCover(isPresented: $isEditPressed) { EditPlanningPeriod.Screen() }
                    .onTapGesture { isEditPressed.toggle() }
                Spacer()
                Text("categories").titleStyle
                Spacer()
                PlusButton()
                    .fullScreenCover(isPresented: $isCreatePressed) { CreateCategory.Screen() }
                    .onTapGesture { isCreatePressed.toggle() }
            }
        }
        
        private var periodPanel: some View {
            Text(periodLabel)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(Colors.white)
                .background(Colors.blue)
                .cornerRadius(5)
        }
        
        private var periodLabel: String {
            guard let period: PlanningPeriod = viewModel.currentPeriod else { return "<period>" }
            return "\(period.start.ddMMyyyy) - \(period.end.ddMMyyyy)"
        }
        
        private var footerPanel: some View {
            HStack(alignment: .top) {
                PurchaseButton()
                    .fullScreenCover(isPresented: $isPurchaseTapped) { RegisterPurchase1.Screen() }
                    .onTapGesture { isPurchaseTapped.toggle() }
                Layout1.xInfinite
            }
        }
        
    }
    
}

struct CategoriesScreen_Previews : PreviewProvider {
    static var previews: some View {
        Categories.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
