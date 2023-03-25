//
//  TextDesign.swift
//  treasury
//
//  Created by sugarbaron on 25.03.2023.
//

import SwiftUI

extension Text {
    
    func design(size: Design.TextSize, color: Rgb = .foreground) -> some View {
        self.font(.system(size.fontStyle, design: .monospaced, weight: .light))
            .foreground(color.ui)
    }
    
}

/// for SFSymbols
extension Image {
    
    func design(size: Design.TextSize, color: Rgb = .foreground) -> some View {
        self.font(.system(size.fontStyle, design: .monospaced, weight: .light))
            .foreground(color.ui)
    }
    
}

extension Design {
    
    enum TextSize {
        case large
        case title
        case regular
        case footnote
        
        var fontStyle: Font.TextStyle {
            switch self {
            case .large:    return .largeTitle
            case .title:    return .title
            case .regular:  return .body
            case .footnote: return .footnote
            }
        }
    }
    
}
