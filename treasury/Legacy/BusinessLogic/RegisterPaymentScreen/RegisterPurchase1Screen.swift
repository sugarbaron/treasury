//
//  RegisterPurchaseScreen.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

extension RegisterPurchase1 {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>

        @StateObject private var viewModel: ViewModel// = .init()
        
        private var category: Category?
        
        //init() { UITextField.appearance().backgroundColor = .clear }
        
        init(_ category: Category? = nil) {
            _viewModel = StateObject(wrappedValue: ViewModel(category))
            UITextField.appearance().backgroundColor = .clear
        }
        
        var body: some View {
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    title
                    Layout.yTitleSpace
                    fields
                    Layout.xInfinite
                    buttons
                    Layout.ySpace
                }
                Layout.xSpace
            }.background(Colors.background)
        }
        
        private var title: some View {
            Text("new purchase\(certainCategoryName)")
                .font(.title)
                .foregroundColor(Colors.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        private var certainCategoryName: String {
            guard viewModel.mode == .certainCategory else { return "" }
            return " for \(viewModel.category)"
        }
        
        private var fields: some View {
            HStack {
                VStack(alignment: .leading) {
                    Layout.ySpace
                    if viewModel.mode == .currentPeriodCategories {
                        Text("category:").labelStyle
                        Layout.ySpace
                    }
                    Text("price:").labelStyle
                    Layout.ySpace
                    Text("comment:").labelStyle
                }
                VStack(alignment: .leading) {
                    Layout.ySpace
                    if viewModel.mode == .currentPeriodCategories {
                        CategoriesMenu(viewModel.categoriesList, $viewModel.category) { choice in
                            viewModel.category = choice
                        }
                        Layout.ySpace
                    }
                    TextField("enter price", text: $viewModel.price).fieldStyle
                        .keyboardType(.numberPad)
                    Layout.ySpace
                    TextField("enter comment", text: $viewModel.comment).fieldStyle
                }
            }
        }
        
        private var buttons: some View {
            HStack {
                YesButton().onTapGesture {
                    viewModel.registerPayment()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer().frame(maxWidth: .infinity)
                NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
            }
        }
        
    }
    
}

// MARK: Tools

extension RegisterPurchase1 {
    
    struct CategoriesMenu : View {
        
        private let categories: [String]
        private var choice: Binding<String>
        private let onTap: (String) -> Void
        
        init(_ categories: [String],
             _ choice: Binding<String>,
             _ onTap: @escaping (String) -> Void) {
            self.categories = categories
            self.choice = choice
            self.onTap = onTap
        }
        
        var body: some View {
            HStack {
                Menu(label) {
                    ForEach(categories) { category in Button(category) { onTap(category) } }
                }
                .font(.title2)
                .foregroundColor(Colors.blue)
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Colors.biege)
            .cornerRadius(5)
        }
        
        private var label: String {
            if choice.wrappedValue.isEmpty { return "choose category" }
            else { return choice.wrappedValue }
        }
        
    }
    
}

extension String : Identifiable {
    
    public var id: String { self }
    
}

struct RegisterPurchase1Screen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPurchase1.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
