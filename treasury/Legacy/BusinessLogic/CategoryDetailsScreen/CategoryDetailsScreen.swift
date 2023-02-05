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
        @State private var isPurchaseTapped: Bool = false
        
        init(_ category: Category) { self.viewModel = ViewModel(category) }
        
        var body: some View {
            HStack {
                Layout1.xSpace
                VStack {
                    Layout1.ySpace
                    titlePanel
                    periodPanel
                    ScrollView { ForEach(viewModel.purchases) { purchase in
                        PurchaseCell(purchase, viewModel.getComment(for: purchase))
                    } }
                    Layout1.ySpace
                    Summary(viewModel.category)
                    Layout1.ySpace
                    footerPanel
                    Layout1.ySpace
                }
                Layout1.xSpace
            }.background(Colors.background)
        }
        
        private var titlePanel: some View {
            HStack(alignment: .top) {
                BackButton().onTapGesture { dismiss() }
                Layout1.xSpace
                Text("\(viewModel.category.name)").titleStyle.frame(maxWidth: .infinity)
                Layout1.xSpace
                RemoveButton()
                    .onTapGesture { isDeleteTapped.toggle() }
                    .alert(isPresented: $isDeleteTapped) {
                        Alert(title: Text("remove category?"),
                              primaryButton: .default(Text("cancel")),
                              secondaryButton: .destructive(Text("remove"), action: removeCategory))
                    }
            }
        }
        
        private var periodPanel: some View {
            Text(periodLabel)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Colors.blue)
                .foregroundColor(Colors.white)
                .cornerRadius(5)
        }
        
        private var periodLabel: String {
            guard let categoryPeriod: PlanningPeriod = viewModel.categoryPeriod else { return "<period>" }
            return "\(categoryPeriod.start.ddMMyyyy) - \(categoryPeriod.end.ddMMyyyy)"
        }
        
        private var footerPanel: some View {
            HStack(alignment: .top) {
                PurchaseButton()
                    .onTapGesture { isPurchaseTapped.toggle() }
                    .fullScreenCover(isPresented: $isPurchaseTapped) {
                        RegisterPurchase1.Screen(viewModel.category)
                    }
                Spacer()
                EditButton()
                    .onTapGesture { isEditTapped.toggle() }
                    .fullScreenCover(isPresented: $isEditTapped) {
                        EditCategory.Screen(viewModel.category)
                    }
            }
        }
        
        private func dismiss() { presentationMode.wrappedValue.dismiss() }
        
        private func removeCategory() { dismiss(); viewModel.removeCategory() }
        
    }
    
}

struct CategoryDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetails.Screen(Category(1, "<name>", 5000, 300, 1))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
