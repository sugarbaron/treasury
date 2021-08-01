//
//  CategoryDetailsScreen.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI

extension CategoryDetails {
    
    struct Screen: View {
        var body: some View {
            Text("category details")
        }
    }
    
}

struct CategoryDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetails.Screen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
