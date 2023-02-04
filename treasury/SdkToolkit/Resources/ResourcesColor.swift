//
//  ResourcesColor.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import UIKit

extension Resources { public final class Color { } }

extension Resources.Color {
    
    public final class Asset { public let name: String; public init(_ name: String) { self.name = name } }
    
}

// MARK: contributions
public extension Rgb {
    
    static func rgb(_ asset: Resources.Color.Asset) -> Rgb { UIColor(named: asset.name)?.cgColor.rgb ?? .eyebleed }
    
}
