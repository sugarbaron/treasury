//
//  CategoryDetailsPurchaseCell.swift
//  treasury
//
//  Created by sugarbaron on 02.08.2021.
//

import SwiftUI 

extension CategoryDetails {
    
    struct PurchaseCell : View {
        
        private let purchase: Purchase
        
        init(_ purchase: Purchase) { self.purchase = purchase }
        
        var body: some View {
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        Text(verbatim: "\(purchase.price.int)")
                            .font(.title2)
                            .frame(width: 90, height: 40)
                            .background(Colors.yellow)
                            .foregroundColor(Colors.black)
                            .cornerRadius(5)
                        Layout.ySpace
                        Text(purchase.date.ddMM)
                            .font(.title2)
                            .frame(width: 90, height: 40)
                            .background(Colors.biege)
                            .foregroundColor(Colors.black)
                            .cornerRadius(5)
                    }
                    Text(verbatim: "\(comment)")
                        .font(.title2)
                        .frame(maxWidth: .infinity, minHeight: 90, idealHeight: 90)
                        .background(Colors.biege)
                        .foregroundColor(Colors.black)
                        .cornerRadius(5)
                }
                Layout.ySpace
            }.frame(maxWidth: .infinity)
        }
        
        private var comment: String {
            if purchase.comment.isEmpty { return purchase.category }
            else { return purchase.comment }
        }
        
    }
    
}

// MARK: Layout

extension CategoryDetails.PurchaseCell {
    
    final class Layout {
        
        private static let xSpaceSize: CGFloat = 10
        private static let ySpaceSize: CGFloat = 10
        
        static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
        static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
        
    }
    
}

struct CategoryDetailsPurchaseCell_Previews : PreviewProvider {
    static var previews: some View {
        CategoryDetails.PurchaseCell(.init(250, "dinner", "nigora"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
