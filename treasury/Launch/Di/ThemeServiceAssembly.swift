//
//  ThemeServiceAssembly.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

import Swinject

extension Themes { final class Assembly { } }

extension Themes.Assembly : Swinject.Assembly {
    
    func assemble(container: Container) {
        container.singleton(ThemeService?.self) { ThemeServiceEngine() }
    }
    
}
