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
                Layout1.xSpace
                VStack {
                    Layout1.ySpace
                    title
                    Layout1.yTitleSpace
                    fields
                    Layout1.yInfinite
                    buttons
                    Layout1.ySpace
                }
                Layout1.xSpace
            }.background(Colors.background)
        }
        
        private var title: some View {
            Text("new category")
                .titleStyle
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        
        private var fields: some View {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Layout1.ySpace
                    Text("name:").labelStyle
                    Layout1.ySpace
                    Text("plan:").labelStyle
                }.frame(alignment: .leading)
                VStack {
                    Layout1.ySpace
                    TextField("enter category name", text: $viewModel.name).fieldStyle
                    Layout1.ySpace
                    TextField("enter plan amount", text: $viewModel.plan).fieldStyle
                        .keyboardType(.numberPad)
                }
            }
        }
        
        private var buttons: some View {
            HStack {
                YesButton().onTapGesture {
                    viewModel.createCategory()
                    presentationMode.wrappedValue.dismiss()
                }
                Layout1.xInfinite
                NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
            }
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
