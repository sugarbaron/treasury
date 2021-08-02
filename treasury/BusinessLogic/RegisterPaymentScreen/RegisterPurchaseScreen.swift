//
//  RegisterPurchaseScreen.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

extension RegisterPurchase {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>

        @StateObject private var viewModel: ViewModel = .init()
        
        init() { UITextField.appearance().backgroundColor = .clear }
        
        var body: some View {
            VStack {
                // title
                Layout.ySpace
                HStack(spacing: 0) {
                    Layout.xSpace
                    Text("register purchase")
                        .font(.title)
                        .foregroundColor(Colors.yellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // fields
                HStack {
                    Layout.xSpace
                    VStack(alignment: .leading) {
                        Layout.ySpace
                        Text("category:").adjust()
                        Layout.ySpace
                        Text("price:").adjust()
                        Layout.ySpace
                        Text("comment:").adjust()
                    }
                    VStack(alignment: .leading) {
                        Layout.ySpace
                        CategoriesMenu(viewModel.categoriesList, $viewModel.category) { choice in
                            viewModel.category = choice
                        }
                        Layout.ySpace
                        TextField("enter price", text: $viewModel.price)
                            .adjust()
                            .keyboardType(.numberPad)
                        Layout.ySpace
                        TextField("enter comment", text: $viewModel.comment)
                            .adjust()
                    }
                    Layout.xSpace
                }
                // ok, cancel buttons
                Spacer().frame(maxHeight: .infinity)
                HStack {
                    Layout.xSpace
                    YesButton().onTapGesture {
                        viewModel.registerPayment()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer().frame(maxWidth: .infinity)
                    NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
                    Layout.xSpace
                }
                Layout.ySpace
            }
            .background(Colors.background)
            
            
        }
        
    }
    
}

// MARK: Tools

private extension TextField {
    
    func adjust() -> some View {
        font(.title2)
        .padding(.vertical, 5)
        .background(Colors.biege)
        .cornerRadius(5)
    }
    
}

private extension Text {
    
    func adjust() -> some View {
        font(.title2)
        .padding(.vertical, 5)
        .foregroundColor(Colors.yellow)
    }
    
}

extension RegisterPurchase {
    
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
                    ForEach(categories) { category in
                        Button(category) { onTap(category) }
                    }
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

// MARK: Layout

extension RegisterPurchase.Screen {
    
    final class Layout {
        
        private static let xSpaceSize: CGFloat = 10
        private static let ySpaceSize: CGFloat = 10
        
        static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
        static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
        
    }
    
}

struct RegisterPurchaseScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPurchase.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
