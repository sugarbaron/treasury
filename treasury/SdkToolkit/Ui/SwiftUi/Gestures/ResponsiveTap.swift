//
//  ResponsiveTap.swift
//  treasury
//
//  Created by sugarbaron on 12.02.2023.
//

import SwiftUI

public extension View {
    
    func onTap(effect: Tap.Effect,
               _ onTap: @escaping () -> Void,
               onRelease: @escaping (Tap.Confirmation) -> Void) -> some View {
        modifier(ResponsiveTap(effect, onTap, onRelease))
    }
    
}

public struct ResponsiveTap : ViewModifier {
    
    private let effect: Tap.Effect
    private let onTap: () -> Void
    private let onRelease: (Tap.Confirmation) -> Void
    private var tappedBorder: Border
    
    @State private var released: Bool
    
    public init(_ effect: Tap.Effect,
                _ onTap: @escaping () -> Void,
                _ onRelease: @escaping (Tap.Confirmation) -> Void) {
        self.effect = effect
        self.onTap = onTap
        self.onRelease = onRelease
        if case .border(let color, let line, let corners) = effect {
            self.tappedBorder = Border(color: color, line: line, corners: corners)
        } else {
            self.tappedBorder = .noBorder
        }
        self.released = true
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(tapBorder)
            .scaleEffect(scale)
            .onTap {
                released = false
                onTap()
            } onRelease: {
                withAnimation(.easeOut(duration: 0.1)) { released = true }
                onRelease($0)
            }
    }
    
    private var scale: CGFloat { released ? 1 : 0.96 }
    
    private var tapped: Bool { released == false }
    
    private var corners: CGFloat { borderEffect ? tappedBorder.corners : 0 }
    
    @ViewBuilder
    private var tapBorder: some View {
        if (borderEffect && tapped) {
            Color.clear
                .border(tappedBorder)
                .blur(radius: 4)
                .border(.clear, line: 0, corners: corners)
        } else {
            Color.clear
        }
    }
    
    private var borderEffect: Bool { if case .border(_, _, _) = effect { return true } else { return false } }
    
}
