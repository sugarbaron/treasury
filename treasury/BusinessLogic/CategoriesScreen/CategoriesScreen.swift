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
            VStack {
                Layout.ySpace
                TitlePanel()
                ScrollView { ForEach(viewModel.categories) { category in
                    HStack { Layout.xSpace; Cell(category); Layout.xSpace }
                } }
                FooterPanel(viewModel.categories.isNotEmpty)
                Layout.ySpace
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
        
        var body: some View {
            HStack(alignment: .top) {
                Layout.xSpace
                Text("categories").font(.title).foregroundColor(Colors.yellow)
                Spacer()
                PlusButton()
                    .background(Colors.yellow)
                    .cornerRadius(5)
                    .fullScreenCover(isPresented: $isCreatePressed) { CreateCategory.Screen() }
                    .onTapGesture { isCreatePressed.toggle() }
                Layout.xSpace
            }
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
                Layout.xSpace
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

// MARK: Layout

extension Categories.Screen {
    
    final class Layout {
        
        private static let xSpaceSize: CGFloat = 10
        private static let ySpaceSize: CGFloat = 10
        
        static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
        static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
        
    }
    
}

struct CategoriesScreen_Previews : PreviewProvider {
    static var previews: some View {
        Categories.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
