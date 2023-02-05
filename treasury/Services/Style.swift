//
//  Style.swift
//  treasury
//
//  Created by sugarbaron on 05.02.2023.
//

import SwiftUI

extension Text {
    
    func title() -> Text { styled(as: .title) }
    
    func regular() -> Text { styled(as: .body) }
    
    func note() -> Text { styled(as: .footnote) }
    
    private func styled(as style: Font.TextStyle) -> Text {
        font(.system(style, design: .monospaced, weight: .light))
    }
    
}

extension Image {
    
    func title() -> some View { styled(as: .title) }
    
    func big() -> some View { styled(as: .largeTitle) }
    
    func regular() -> some View { styled(as: .body) }
    
    func note() -> some View { styled(as: .footnote) }
    
    private func styled(as style: Font.TextStyle) -> some View {
        font(.system(style, design: .monospaced, weight: .light))
    }
    
}

