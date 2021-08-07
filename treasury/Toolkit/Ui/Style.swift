//
//  Style.swift
//  treasury
//
//  Created by sugarbaron on 07.08.2021.
//

import SwiftUI

extension Text {
    
    var labelStyle: some View {
        font(.title2)
        .frame(alignment: .trailing)
        .padding(.vertical, 5)
        .foregroundColor(Colors.yellow)
    }
    
    var titleStyle: some View { font(.title).foregroundColor(Colors.yellow) }
    
}

extension TextField {
    
    var fieldStyle: some View {
        font(.title2)
        .padding(.vertical, 5)
        .background(Colors.biege)
        .cornerRadius(5)
    }
    
}
