//
//  RegisterPaymentScreen.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

extension RegisterPayment {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>

        @StateObject private var viewModel: ViewModel = .init()
        
        init() { UITextField.appearance().backgroundColor = .clear }
        
        var body: some View {
            VStack {
                // title
                Spacer().frame(height: Layout.ySpace)
                HStack {
                    Spacer().frame(width: Layout.xSpace)
                    Text("register  payment")
                        .font(.title)
                        .foregroundColor(Colors.yellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // fields
                HStack {
                    Spacer().frame(width: Layout.xSpace)
                    VStack(alignment: .leading) {
                        Spacer().frame(height: Layout.ySpace)
                        Text("category:").adjust()
                        Spacer().frame(height: Layout.ySpace)
                        Text("price:").adjust()
                        Spacer().frame(height: Layout.ySpace)
                        Text("comment:").adjust()
                    }
                    VStack(alignment: .leading) {
                        Spacer().frame(height: Layout.ySpace)
                        CategoriesMenu(viewModel.categoriesList, $viewModel.category) { choice in
                            viewModel.category = choice
                        }
                        Spacer().frame(height: Layout.ySpace)
                        TextField("enter price", text: $viewModel.price)
                            .adjust()
                            .keyboardType(.numberPad)
                        Spacer().frame(height: Layout.ySpace)
                        TextField("enter comment", text: $viewModel.comment)
                            .adjust()
                    }
                    Spacer().frame(width: Layout.xSpace)
                }
                // ok, cancel buttons
                Spacer().frame(maxHeight: .infinity)
                HStack {
                    Spacer().frame(width: Layout.xSpace)
                    YesButton().onTapGesture {
                        viewModel.registerPayment()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer().frame(maxWidth: .infinity)
                    NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
                    Spacer().frame(width: Layout.xSpace)
                }
                Spacer().frame(height: Layout.ySpace)
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
        .padding(5)
        .foregroundColor(Colors.yellow)
    }
    
}

extension RegisterPayment {
    
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
                        //CustomButton(category).onTapGesture { onTap(category) }
                    }
                }
                .font(.title2)
                .foregroundColor(Colors.blue)
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .leading)
                //Spacer().frame(maxWidth: .infinity)
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

private extension CustomButton {
    
    func adjust() -> some View {
        background(Colors.biege)
    }
    
}

extension String : Identifiable {
    
    public var id: String { self }
    
}

// MARK: Layout

extension RegisterPayment.Screen {
    
    final class Layout {
        
        static let xSpace: CGFloat = 10
        static let ySpace: CGFloat = 20
        
    }
    
}

struct RegisterPaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPayment.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
