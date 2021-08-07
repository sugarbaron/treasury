//
//  CategoriesCreateScreen.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import SwiftUI

// MARK: Screen

extension CreateCategory {
    
    struct Screen : View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>

        @StateObject private var viewModel: ViewModel = .init()
        
        init() { UITextField.appearance().backgroundColor = .clear }
        
        var body: some View {
            VStack {
                Layout.ySpace
                HStack(spacing: 0) {
                    Layout.xSpace
                    Text("new category")
                        .titleStyle
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                HStack {
                    Layout.xSpace
                    VStack(alignment: .leading, spacing: 0) {
                        Layout.ySpace
                        Text("name:").labelStyle
                        Layout.ySpace
                        Text("plan:").labelStyle
                    }.frame(alignment: .leading)
                    VStack {
                        Layout.ySpace
                        TextField("enter category name", text: $viewModel.name).fieldStyle
                        Layout.ySpace
                        TextField("enter plan amount", text: $viewModel.plan).fieldStyle
                            .keyboardType(.numberPad)
                    }
                    Layout.xSpace
                }
                Spacer().frame(maxHeight: .infinity)
                HStack {
                    Layout.xSpace
                    YesButton().onTapGesture {
                        viewModel.createCategory()
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

struct NewCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategory.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
