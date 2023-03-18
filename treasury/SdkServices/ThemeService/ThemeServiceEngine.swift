//
//  ThemeServiceEngine.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

// MARK: constructor
    public final class ThemeServiceEngine {
        
        // todo: internal core data storage
        
        private let dark: Theme
        
        public init() {
            self.dark = Theme(-1, "dark", This.dark)
        }
        
    }

// MARK: interface
extension ThemeServiceEngine : ThemeService {
    
    public var current: Theme { dark }
    
    public var all: [Theme] { [dark] }
    
    public func save(new theme: Theme.Draft) { /* todo */ }
    
    public func update(_ theme: Theme) { /* todo */ }
    
    public func delete(_ id: Int) { /* todo */ }
    
}

// MARK: tools
private extension ThemeServiceEngine {
    
    static var dark: Theme.ColorScheme {
        .init(background: .rgb(.gray),
              foreground: .rgb(.gray04),
              accent1: .rgb(.orange01),
              accent2: .rgb(.yellow),
              warning1: .rgb(.red),
              warning2: .rgb(.red02),
              success1: .rgb(.green),
              success2: .rgb(.green),
              uprised: .rgb(.gray02),
              lowered: .rgb(.gray01),
              regular: .rgb(.gray04),
              title: .rgb(.white),
              selected: .rgb(.white),
              disabled: .rgb(.gray03))
    }
    
    typealias This = ThemeServiceEngine
    
}
