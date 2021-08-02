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
                        .font(.title)
                        .foregroundColor(Colors.yellow)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                HStack {
                    Layout.xSpace
                    VStack(alignment: .leading, spacing: 0) {
                        Layout.ySpace
                        Text("name:").adjust()
                        Layout.ySpace
                        Text("plan:").adjust()
                        Layout.ySpace
                        Text("spent:").adjust()
                    }.frame(alignment: .leading)
                    VStack {
                        Layout.ySpace
                        TextField("enter category name", text: $viewModel.name)
                            .adjust()
                        Layout.ySpace
                        TextField("enter plan amount", text: $viewModel.plan)
                            .adjust()
                            .keyboardType(.numberPad)
                        Layout.ySpace
                        TextField("enter already spent amount", text: $viewModel.fact)
                            .adjust()
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

// MARK: Button

extension CreateCategory {
    
    private struct Button : View {
        
        private let imageName: String
        
        init(_ imageName: String) { self.imageName = imageName }
        
        var body: some View {
            Image(systemName: imageName)
                .font(.title2)
                .foregroundColor(Colors.black)
                .padding()
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
        .frame(alignment: .trailing)
        .padding(.vertical, 5)
        .foregroundColor(Colors.yellow)
    }
    
}

// MARK: Layout

extension CreateCategory.Screen {
    
    final class Layout {
        
        private static let xSpaceSize: CGFloat = 10
        private static let ySpaceSize: CGFloat = 10
        
        static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
        static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
        
    }
    
}

struct NewCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategory.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
