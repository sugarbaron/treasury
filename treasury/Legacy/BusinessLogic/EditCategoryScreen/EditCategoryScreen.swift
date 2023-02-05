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
                Layout1.xSpace
                VStack {
                    Layout1.ySpace
                    titlePanel
                    Layout1.yTitleSpace
                    fields
                    Layout1.xInfinite
                    buttons
                    Layout1.ySpace
                }
                Layout1.xSpace
            }.background(Colors.background)
        }
        
        private var titlePanel: some View {
            Text("edit category").titleStyle
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
                    viewModel.editCategory()
                    presentationMode.wrappedValue.dismiss()
                }
                Layout1.xInfinite
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
