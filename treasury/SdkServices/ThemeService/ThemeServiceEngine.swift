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
        .init(background: .gray,
              foreground: .gray03,
              accent1: .orange,
              accent2: .yellow,
              warning: .red,
              success: .green,
              uprised: .gray02,
              lowered: .gray01,
              regular: .gray03,
              title: .gray04,
              selected: .gray04,
              disabled: .gray05)
    }
    
    typealias This = ThemeServiceEngine
    
}
