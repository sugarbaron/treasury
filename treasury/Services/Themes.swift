//
//  Themes.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import SwiftUI

/// namespace class
final class Themes {
    
    static var current: Theme = `default`
    
    private static let `default`: Theme = .init(0, "default", .default)
    
}

private extension Theme.ColorScheme {
    
    static var `default`: Theme.ColorScheme {
        .init(background: .rgb(.gray),
              foreground: .rgb(.gray04),
              accent1: .rgb(.orange),
              accent2: .rgb(.yellow),
              warning: .rgb(.red),
              success: .rgb(.green),
              uprised: .rgb(.gray02),
              lowered: .rgb(.gray01),
              regular: .rgb(.gray04),
              title: .rgb(.white),
              selected: .rgb(.white),
              disabled: .rgb(.gray03))
    }
    
}

// MARK: contributions
extension Color {
    
    static var background: Color { Themes.current.background.ui }
    static var foreground: Color { Themes.current.foreground.ui }
    static var accent1: Color { Themes.current.accent1.ui }
    static var accent2: Color { Themes.current.accent2.ui }
    static var warning: Color { Themes.current.warning.ui }
    static var success: Color { Themes.current.success.ui }
    static var uprised: Color { Themes.current.uprised.ui }
    static var lowered: Color { Themes.current.lowered.ui }
    static var regular: Color { Themes.current.regular.ui }
    static var title: Color { Themes.current.title.ui }
    static var selected: Color { Themes.current.selected.ui }
    static var disabled: Color { Themes.current.disabled.ui }
    
}

extension Rgb {
    
    static var background: Rgb { Themes.current.background }
    static var foreground: Rgb { Themes.current.foreground }
    static var accent1: Rgb { Themes.current.accent1 }
    static var accent2: Rgb { Themes.current.accent2 }
    static var warning: Rgb { Themes.current.warning }
    static var success: Rgb { Themes.current.success }
    static var uprised: Rgb { Themes.current.uprised }
    static var lowered: Rgb { Themes.current.lowered }
    static var regular: Rgb { Themes.current.regular }
    static var title: Rgb { Themes.current.title }
    static var selected: Rgb { Themes.current.selected }
    static var disabled: Rgb { Themes.current.disabled }
    
}
