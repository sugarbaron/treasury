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
        
        public let background: Resources.Color
        public let foreground: Resources.Color
        public let accent1: Resources.Color
        public let accent2: Resources.Color
        public let warning: Resources.Color
        public let success: Resources.Color
        public let uprised: Resources.Color
        public let lowered: Resources.Color
        public let regular: Resources.Color
        public let title: Resources.Color
        public let selected: Resources.Color
        public let disabled: Resources.Color
        
        public init(background: Resources.Color,
                    foreground: Resources.Color,
                    accent1: Resources.Color,
                    accent2: Resources.Color,
                    warning: Resources.Color,
                    success: Resources.Color,
                    uprised: Resources.Color,
                    lowered: Resources.Color,
                    regular: Resources.Color,
                    title: Resources.Color,
                    selected: Resources.Color,
                    disabled: Resources.Color) {
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
