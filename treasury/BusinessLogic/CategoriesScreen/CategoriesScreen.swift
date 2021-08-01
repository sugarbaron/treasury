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
        @State private var cellWidth: CGFloat = .zero
        
        var body: some View {
            VStack {
                Layout.ySpace
                TitlePanel()
                ScrollView { ForEach(viewModel.categories) { category in
                    HStack { Layout.xSpace; Categories.Cell(category, $cellWidth); Layout.xSpace }
                } }
                FooterPanel()
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
        
        var body: some View {
            HStack(alignment: .top) {
                Layout.xSpace
                Text("categories").font(.title).foregroundColor(Colors.yellow)
                Spacer()
                PlusButton()
                    .background(Colors.yellow)
                    .cornerRadius(5)
                Layout.xSpace
            }
        }
        
    }
    
    private struct PlusButton : View {
        
        @State private var isPressed: Bool
        
        init() { self.isPressed = false }
        
        var body: some View {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(Colors.black)
                .padding()
                .fullScreenCover(isPresented: $isPressed) { CreateCategory.Screen() }
                .onTapGesture { isPressed.toggle() }
        }
        
    }
    
}
// MARK: FooterPanel

extension Categories.Screen {
    
    private struct FooterPanel : View {
        
        var body: some View {
            HStack(alignment: .top) {
                Layout.xSpace
                PurchaseButton()
                    .background(Colors.yellow)
                    .cornerRadius(5)
                Spacer().frame(maxWidth: .infinity)
            }
        }
        
    }
    
    private struct PurchaseButton : View {
        
        @State private var isPressed: Bool
        
        init() { self.isPressed = false }
        
        var body: some View {
            Image(systemName: "dollarsign.circle")
                .font(.largeTitle)
                .foregroundColor(Colors.black)
                .padding(10)
                .fullScreenCover(isPresented: $isPressed) { RegisterPayment.Screen() }
                .onTapGesture { isPressed.toggle() }
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
