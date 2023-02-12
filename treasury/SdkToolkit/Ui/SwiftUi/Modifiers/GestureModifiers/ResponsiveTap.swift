//
//  ResponsiveTap.swift
//  treasury
//
//  Created by sugarbaron on 12.02.2023.
//

import SwiftUI

public extension View {
    
    func onTap(effect: Tap.Effect,
               rounded: CGFloat = 0.0,
               _ onTap: @escaping () -> Void,
               onRelease: @escaping (Tap.Confirmation) -> Void) -> some View {
        modifier(ResponsiveTap(effect, rounded, onTap, onRelease))
    }
    
}

public struct ResponsiveTap : ViewModifier {
    
    private let effect: Tap.Effect
    private let corners: CGFloat
    private let onTap: () -> Void
    private let onRelease: (Tap.Confirmation) -> Void
    
    @State private var shading: CGFloat
    @State private var border: Tap.Effect.Border
    @State private var scale: CGFloat
    
    public init(_ effect: Tap.Effect,
                _ rounded: CGFloat,
                _ onTap: @escaping () -> Void,
                _ onRelease: @escaping (Tap.Confirmation) -> Void) {
        self.effect = effect
        self.corners = rounded
        self.onTap = onTap
        self.onRelease = onRelease
        self.shading = Original.shade
        self.border  = Original.border
        self.scale   = Original.scale
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(Color.black.opacity(shading).rounded(corners))
            .scaleEffect(scale)
            .border(border.color.ui, width: border.width, rounded: border.rounded)
            .onTap {
                shading = Tapped.shade
                if case .border(let color, let width, let rounded) = effect { border = (color, width, rounded) }
                if case .scale = effect { scale = Tapped.scale }
                onTap()
            } onRelease: {
                shading = Original.shade
                if case .border = effect { border = Original.border }
                if case .scale  = effect { scale = Original.scale }
                onRelease($0)
            }
    }
    
}

private final class Original {
    static let shade: CGFloat = 0.0
    static let scale: CGFloat = 1.0
    static let border: Tap.Effect.Border = (color: .black, width: 0.0, rounded: 0.0)
}

private final class Tapped {
    static let shade: CGFloat = 0.1
    static let scale: CGFloat = 0.96
}
