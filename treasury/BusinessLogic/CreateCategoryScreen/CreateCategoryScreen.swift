//
//  CategoriesCreateScreen.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import SwiftUI

extension CreateCategory {
    
    struct Screen : View {
        
        private let viewModel: ViewModel
        
        init() { self.viewModel = .init() }
        
        var body: some View {
            VStack {
                Spacer().frame(height: Layout.ySpace)
                Text("new category")
                    .font(.title)
                    .foregroundColor(Colors.yellow)
                HStack {
                    Spacer().frame(width: Layout.xSpace)
                    VStack(alignment: .leading) {
                        Spacer().frame(height: Layout.ySpace)
                        Text("name:").adjust()
                        Spacer().frame(height: Layout.ySpace)
                        Text("plan:").adjust()
                        Spacer().frame(height: Layout.ySpace)
                        Text("fact:").adjust()
                    }
                    VStack {
                        Spacer().frame(height: Layout.ySpace)
                        TextField("enter category name", text: viewModel.$name)
                            .adjust()
                        Spacer().frame(height: Layout.ySpace)
                        TextField("enter plan amount", text: viewModel.$plan)
                            .adjust()
                            .keyboardType(.numberPad)
                        Spacer().frame(height: Layout.ySpace)
                        TextField("enter fact amount", text: viewModel.$fact)
                            .adjust()
                            .keyboardType(.numberPad)
                    }
                    Spacer().frame(width: Layout.xSpace)
                }
                Spacer().frame(maxHeight: .infinity)
                HStack {
                    Spacer().frame(width: Layout.xSpace)
                    CreateCategory.Button("xmark")
                        .background(Colors.red)
                        .cornerRadius(5)
                    Spacer().frame(maxWidth: .infinity)
                    CreateCategory.Button("checkmark")
                        .background(Colors.yellow)
                        .cornerRadius(5)
                    Spacer().frame(width: Layout.xSpace)
                }
                Spacer().frame(height: Layout.ySpace)
            }
            .background(Colors.background)
        }
        
    }
    
}

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

private extension TextField {
    
    func adjust() -> some View {
        font(.title2)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
}

private extension Text {
    
    func adjust() -> some View {
        font(.title2)
            .padding(5)
            .foregroundColor(Colors.yellow)
    }
    
}

extension CreateCategory.Screen {
    
    final class Layout {
        
        static let xSpace: CGFloat = 10
        static let ySpace: CGFloat = 20
        
    }
    
}

struct NewCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategory.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
