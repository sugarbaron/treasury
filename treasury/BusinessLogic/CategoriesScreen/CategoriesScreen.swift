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
        
        var body: some View {
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    TitlePanel()
                    Layout.ySpace
                    PeriodPanel($viewModel.currentPeriod)
                    ScrollView { ForEach(viewModel.categories) { category in Cell(category) } }
                    Layout.ySpace
                    FooterPanel(viewModel.categories.isNotEmpty)
                    Layout.ySpace
                }
                Layout.xSpace
            }
            .background(Colors.background)
            .frame(maxWidth: .infinity)
        }
        
    }
    
}

// MARK: TitlePanel

extension Categories.Screen {
    
    private struct TitlePanel : View {
        
        @State private var isCreatePressed: Bool = false
        @State private var isEditPressed: Bool = false
        
        var body: some View {
            HStack(alignment: .top) {
                EditPeriodButton()
                    .fullScreenCover(isPresented: $isEditPressed) { EditPlanningPeriod.Screen() }
                    .onTapGesture { isEditPressed.toggle() }
                Spacer()
                Text("categories").font(.title).foregroundColor(Colors.yellow)
                Spacer()
                PlusButton()
                    .fullScreenCover(isPresented: $isCreatePressed) { CreateCategory.Screen() }
                    .onTapGesture { isCreatePressed.toggle() }
            }
        }
        
    }
    
}

// MARK: period panel

extension Categories.Screen {
    
    private struct PeriodPanel : View {
        
        private let period: Binding<PlanningPeriod?>
        
        init(_ period: Binding<PlanningPeriod?>) { self.period = period }
        
        var body: some View {
            Text(periodLabel)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(Colors.white)
                .background(Colors.blue)
                .cornerRadius(5)
        }
        
        private var periodLabel: String {
            guard let period: PlanningPeriod = period.wrappedValue else { return "<period>" }
            return "\(period.start.ddMMyyyy) - \(period.end.ddMMyyyy)"
        }
        
    }
    
}

// MARK: FooterPanel

extension Categories.Screen {
    
    private struct FooterPanel : View {
        
        private var unlocked: Bool
        
        @State private var isPurchaseTapped: Bool = false
        
        init(_ unlocked: Bool) { self.unlocked = unlocked }
        
        var body: some View {
            HStack(alignment: .top) {
                if unlocked {
                    PurchaseButton()
                        .fullScreenCover(isPresented: $isPurchaseTapped) { RegisterPurchase.Screen() }
                        .onTapGesture { isPurchaseTapped.toggle() }
                }
                Spacer().frame(maxWidth: .infinity)
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
