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
        private let comment: String
        
        init(_ purchase: Purchase, _ comment: String) {
            self.purchase = purchase
            self.comment = comment
        }
        
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
        CategoryDetails.PurchaseCell(.init(1, 250, 1, "nigora"), "dinners")
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
