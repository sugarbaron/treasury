//
//  EditCategoryScreen.swift
//  treasury
//
//  Created by sugarbaron on 02.08.2021.
//

import SwiftUI

// MARK: Screen

extension EditCategory {
    
    struct Screen : View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>
        
        private let category: Category
        
        @ObservedObject private var viewModel: ViewModel
        
        init(_ category: Category) {
            self.category = category
            self.viewModel = .init(category)
        }
        
        var body: some View {
            HStack {
                Layout.xSpace
                VStack {
                    Layout.ySpace
                    titlePanel
                    Layout.yTitleSpace
                    fields
                    Layout.xInfinite
                    buttons
                    Layout.ySpace
                }
                Layout.xSpace
            }.background(Colors.background)
        }
        
        private var titlePanel: some View {
            Text("edit category").titleStyle
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        
        private var fields: some View {
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
        }
        
        private var buttons: some View {
            HStack {
                YesButton().onTapGesture {
                    viewModel.editCategory()
                    presentationMode.wrappedValue.dismiss()
                }
                Layout.xInfinite
                NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
            }
        }
        
    }
    
}

struct EditCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditCategory.Screen(.init(1, "phone", 600, 150, 1))
    }
}
