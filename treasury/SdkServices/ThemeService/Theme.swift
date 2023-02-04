//
//  Theme.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

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
        public let warning: Rgb
        public let success: Rgb
        public let uprised: Rgb
        public let lowered: Rgb
        public let regular: Rgb
        public let title: Rgb
        public let selected: Rgb
        public let disabled: Rgb
        
        public init(background: Rgb,
                    foreground: Rgb,
                    accent1: Rgb,
                    accent2: Rgb,
                    warning: Rgb,
                    success: Rgb,
                    uprised: Rgb,
                    lowered: Rgb,
                    regular: Rgb,
                    title: Rgb,
                    selected: Rgb,
                    disabled: Rgb) {
            self.background = background
            self.foreground = foreground
            self.accent1 = accent1
            self.accent2 = accent2
            self.warning = warning
            self.success = success
            self.uprised = uprised
            self.lowered = lowered
            self.regular = regular
            self.title = title
            self.selected = selected
            self.disabled = disabled
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
