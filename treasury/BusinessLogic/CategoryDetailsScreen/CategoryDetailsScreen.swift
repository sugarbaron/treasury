//
//  CategoryDetailsScreen.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

extension CategoryDetails {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>
        
        private let viewModel: ViewModel
        
        @State private var isDeleteTapped: Bool = false
        
        init(_ category: Category) { self.viewModel = ViewModel(category) }
        
        var body: some View {
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    HStack(alignment: .top) {
                        BackButton().onTapGesture { dismiss() }
                        Spacer().frame(maxWidth: .infinity)
                    }
                    CategoryCard(viewModel.category)
                    if viewModel.purshases.isNotEmpty { purchasesTitle }
                    ScrollView { ForEach(viewModel.purshases) { purchase in
                        PurchaseCell(purchase)
                    } }
                    HStack(alignment: .top) {
                        Spacer().frame(maxWidth: .infinity)
                        RemoveButton()
                            .onTapGesture { isDeleteTapped.toggle() }
                            .alert(isPresented: $isDeleteTapped) {
                                Alert(title: Text("remove category?"),
                                      primaryButton: .default(Text("cancel")),
                                      secondaryButton: .destructive(Text("remove"), action: removeCategory))
                            }
                    }
                    Layout.ySpace
                }
                Layout.xSpace
            }.background(Colors.background)
        }
        
        private var purchasesTitle: some View {
            Text("purchases")
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Colors.blue)
                .foregroundColor(Colors.white)
                .cornerRadius(5)
        }
        
        private func dismiss() { presentationMode.wrappedValue.dismiss() }
        
        private func removeCategory() { dismiss(); viewModel.removeCategory() }
        
    }
    
}

// MARK: Layout

extension CategoryDetails.Screen {
    
    final class Layout {
        
        private static let xSpaceSize: CGFloat = 10
        private static let ySpaceSize: CGFloat = 10
        
        static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
        static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
        
    }
    
}

struct CategoryDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetails.Screen(Category("<name>", 5000, 300))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
