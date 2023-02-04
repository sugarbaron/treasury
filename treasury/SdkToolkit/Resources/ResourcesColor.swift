//
//  ResourcesColor.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import UIKit

extension Resources { final class Color { } }

extension Resources.Color {
    
    final class Asset { let name: String; init(_ name: String) { self.name = name } }
    
}

// MARK: contributions
extension Rgb {
    
    static func rgb(_ asset: Resources.Color.Asset) -> Rgb { UIColor(named: asset.name)?.cgColor.rgb ?? .eyebleed }
    
}
