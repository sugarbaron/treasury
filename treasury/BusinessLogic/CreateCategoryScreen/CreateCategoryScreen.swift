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
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    Text("new category")
                        .titleStyle
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    HStack {
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
                    }
                    Layout.yInfinite
                    HStack {
                        YesButton().onTapGesture {
                            viewModel.createCategory()
                            presentationMode.wrappedValue.dismiss()
                        }
                        Layout.xInfinite
                        NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
                    }
                    Layout.ySpace
                }
                Layout.xSpace
            }.background(Colors.background)
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
