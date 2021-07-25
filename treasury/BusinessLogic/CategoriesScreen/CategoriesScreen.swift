//
//  CategoriesScreen.swift
//  treasury
//
//  Created by sugarbaron on 22.07.2021.
//

import SwiftUI

struct CategoriesScreen : View {
    
    init() { UITableView.appearance().backgroundColor = UIColor(Colors.background) }
    
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
            Spacer()
        }
        .background(Colors.background)
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

extension CategoriesScreen {
    
    final class Layout {
        
        static let xSpace: CGFloat = 10
        static let ySpace: CGFloat = 10
        
    }
    
}

struct CategoriesScreen_Previews : PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
