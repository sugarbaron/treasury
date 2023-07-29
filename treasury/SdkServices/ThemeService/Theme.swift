//
//  Theme.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

import Bumblebee

@dynamicMemberLookup
public final class Theme {
    
    public let id: Int
    public let name: String
    public let colorScheme: ColorScheme
    
    init(_ id: Int, _ name: String, _ colorScheme: ColorScheme) {
        self.id = id
        self.name = name
        self.colorScheme = colorScheme
    }
    
    public subscript<T>(dynamicMember field: KeyPath<ColorScheme, T>) -> T { colorScheme[keyPath: field] }
    
}

extension Theme {
    
    public final class ColorScheme {
        
        public let background: Rgb
        public let foreground: Rgb
        public let accent1: Rgb
        public let accent2: Rgb
        public let warning1: Rgb
        public let warning2: Rgb
        public let success1: Rgb
        public let success2: Rgb
        public let uprised: Rgb
        public let lowered: Rgb
        public let title: Rgb
        public let selected: Rgb
        public let disabled1: Rgb
        public let disabled2: Rgb
        
        public init(background: Rgb,
                    foreground: Rgb,
                    accent1: Rgb,
                    accent2: Rgb,
                    warning1: Rgb,
                    warning2: Rgb,
                    success1: Rgb,
                    success2: Rgb,
                    uprised: Rgb,
                    lowered: Rgb,
                    title: Rgb,
                    selected: Rgb,
                    disabled1: Rgb,
                    disabled2: Rgb) {
            self.background = background
            self.foreground = foreground
            self.accent1 = accent1
            self.accent2 = accent2
            self.warning1 = warning1
            self.warning2 = warning2
            self.success1 = success1
            self.success2 = success2
            self.uprised = uprised
            self.lowered = lowered
            self.title = title
            self.selected = selected
            self.disabled1 = disabled1
            self.disabled2 = disabled2
        }
        
    }
    
}

extension Theme {
    
    public final class Draft {
        
        public let name: String
        public let colorScheme: ColorScheme
        
        init(_ name: String, _ colorScheme: ColorScheme) {
            self.name = name
            self.colorScheme = colorScheme
        }
        
    }
    
}
