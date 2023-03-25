//
//  Themes.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import SwiftUI

/// namespace class
final class Themes {
    
    static var current: Theme = fallback
    
    private static let fallback: Theme = .init(0, "fallback", .fallback)
    
}

private extension Theme.ColorScheme {
    
    static var fallback: Theme.ColorScheme {
        .init(background: .rgb(.gray),
              foreground: .rgb(.gray03),
              accent1: .rgb(.orange01),
              accent2: .rgb(.yellow),
              warning1: .rgb(.red03),
              warning2: .rgb(.red02),
              success1: .rgb(.green01),
              success2: .rgb(.green),
              uprised: .rgb(.gray02),
              lowered: .rgb(.gray01),
              title: .rgb(.gray04),
              selected: .rgb(.white),
              disabled1: .rgb(.gray03),
              disabled2: .rgb(.gray02))
    }
    
}

// MARK: contributions
extension Color {
    
    static var background: Color { Themes.current.background.ui }
    static var foreground: Color { Themes.current.foreground.ui }
    static var accent1: Color { Themes.current.accent1.ui }
    static var accent2: Color { Themes.current.accent2.ui }
    static var warning1: Color { Themes.current.warning1.ui }
    static var warning2: Color { Themes.current.warning2.ui }
    static var success1: Color { Themes.current.success1.ui }
    static var success2: Color { Themes.current.success2.ui }
    static var uprised: Color { Themes.current.uprised.ui }
    static var lowered: Color { Themes.current.lowered.ui }
    static var title: Color { Themes.current.title.ui }
    static var selected: Color { Themes.current.selected.ui }
    static var disabled1: Color { Themes.current.disabled1.ui }
    static var disabled2: Color { Themes.current.disabled2.ui }
    
}

extension Rgb {
    
    static var background: Rgb { Themes.current.background }
    static var foreground: Rgb { Themes.current.foreground }
    static var accent1: Rgb { Themes.current.accent1 }
    static var accent2: Rgb { Themes.current.accent2 }
    static var warning1: Rgb { Themes.current.warning1 }
    static var warning2: Rgb { Themes.current.warning2 }
    static var success1: Rgb { Themes.current.success1 }
    static var success2: Rgb { Themes.current.success2 }
    static var uprised: Rgb { Themes.current.uprised }
    static var lowered: Rgb { Themes.current.lowered }
    static var title: Rgb { Themes.current.title }
    static var selected: Rgb { Themes.current.selected }
    static var disabled1: Rgb { Themes.current.disabled1 }
    static var disabled2: Rgb { Themes.current.disabled2 }
    
}
