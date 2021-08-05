//
//  CategoryDetailsScreen.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

// MARK: Screen

extension CategoryDetails {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>
        
        private let viewModel: ViewModel
        
        @State private var isDeleteTapped: Bool = false
        @State private var isEditTapped: Bool = false
        
        init(_ category: Category) { self.viewModel = ViewModel(category) }
        
        var body: some View {
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    HStack(alignment: .top) {
                        BackButton().onTapGesture { dismiss() }
                        Layout.xSpace
                        VStack {
                            Text("\(viewModel.category.name)")
                                .font(.title)
                                .frame(height: 33)
                                .foregroundColor(Colors.yellow)
                            Text("15.05 - 15.06")
                                .font(.title2)
                                .frame(height: 22)
                                .foregroundColor(Colors.yellow)
                        }.frame(maxWidth: .infinity)
                        Layout.xSpace
                        RemoveButton()
                            .onTapGesture { isDeleteTapped.toggle() }
                            .alert(isPresented: $isDeleteTapped) {
                                Alert(title: Text("remove category?"),
                                      primaryButton: .default(Text("cancel")),
                                      secondaryButton: .destructive(Text("remove"), action: removeCategory))
                            }
                    }
                    if viewModel.purshases.isNotEmpty { purchasesTitle }
                    ScrollView { ForEach(viewModel.purshases) { purchase in
                        PurchaseCell(purchase)
                    } }
                    Layout.ySpace
                    Summary(viewModel.category)
                    Layout.ySpace
                    HStack(alignment: .top) {
                        EditButton()
                            .onTapGesture { isEditTapped.toggle() }
                            .fullScreenCover(isPresented: $isEditTapped) {
                                EditCategory.Screen(viewModel.category)
                            }
                        Spacer().frame(maxWidth: .infinity)
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

struct CategoryDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetails.Screen(Category("<name>", 5000, 300, 1))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
