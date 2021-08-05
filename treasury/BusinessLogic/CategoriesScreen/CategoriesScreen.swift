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
                    PeriodPanel(period)
                    ScrollView { ForEach(viewModel.categories) { category in
                        Cell(category)
                    } }
                    FooterPanel(viewModel.categories.isNotEmpty)
                    Layout.ySpace
                }
                Layout.xSpace
            }
            .background(Colors.background)
            .frame(maxWidth: .infinity)
        }
        
        private var period: String {
            guard let currentPeriod: PlanningPeriod = viewModel.currentPeriod else { return "<period>" }
            return "\(currentPeriod.start.ddMMyyyy) - \(currentPeriod.end.ddMMyyyy)"
        }
        
    }
    
}

// MARK: TitlePanel

extension Categories.Screen {
    
    private struct TitlePanel : View {
        
        @State private var isCreatePressed: Bool = false
        
        var body: some View {
            HStack(alignment: .top) {
                Text("categories").font(.title).foregroundColor(Colors.yellow)
                Spacer()
                PlusButton()
                    .background(Colors.yellow)
                    .cornerRadius(5)
                    .fullScreenCover(isPresented: $isCreatePressed) { CreateCategory.Screen() }
                    .onTapGesture { isCreatePressed.toggle() }
            }
        }
        
    }
    
}

// MARK: period panel

extension Categories.Screen {
    
    private struct PeriodPanel : View {
        
        private let periodLabel: String
        
        init(_ label: String) { self.periodLabel = label }
        
        var body: some View {
            Text(periodLabel)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(Colors.white)
                .background(Colors.blue)
                .cornerRadius(5)
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
                        .background(Colors.yellow)
                        .cornerRadius(5)
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
