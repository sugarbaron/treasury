//
//  CategoriesScreen.swift
//  treasury
//
//  Created by sugarbaron on 22.07.2021.
//

import SwiftUI

extension Categories {

    struct Screen : View {
        
        @ObservedObject var viewModel: ViewModel
        
        init() {
            self.viewModel = ViewModel()
        }
        
        var body: some View {
            VStack {
                Spacer().frame(height: Layout.ySpace)
                HStack {
                    Spacer().frame(maxWidth: .infinity)
                    PlusButton()
                        .background(Colors.blue)
                        .cornerRadius(5)
                    Spacer().frame(width: Layout.xSpace)
                }
                ForEach(viewModel.categories) { category in Categories.Cell(category) }
                Spacer()
            }
            .background(Colors.background)
        }
        
    }
    
}

private struct PlusButton : View {
    
    var body: some View {
        Image(systemName: "plus")
            .font(.title2.bold())
            .foregroundColor(Colors.white)
            .padding()
    }
    
}

extension Categories.Screen {
    
    final class Layout {
        
        static let xSpace: CGFloat = 10
        static let ySpace: CGFloat = 10
        
    }
    
}

struct CategoriesScreen_Previews : PreviewProvider {
    static var previews: some View {
        Categories.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
