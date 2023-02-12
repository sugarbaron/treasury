//
//  ModifiersAdvanced.swift
//  ios-x-gps-fleet
//
//  Created by sugarbaron on 31.01.2023.
//

import SwiftUI
import Combine

public extension View {
    
    func underlay(_ layer: some View) -> some View { layer.overlay(self) }
    
    func onTap(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        onTapGesture(count: count, perform: action)
    }
    
    func rounded(_ radius: CGFloat, antialiased: Bool = true) -> some View {
        cornerRadius(radius, antialiased: antialiased)
    }
    
    func foreground(_ color: Color) -> some View { foregroundColor(color) }
    
    func subscribe<P:Publisher>(to publisher: P, _ reaction: @escaping (P.Output) -> Void)
    -> some View where P.Failure == Never {
        onReceive(publisher, perform: reaction)
    }
    
    func frame(_ size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    func frame(w: CGFloat, h: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: w, height: h, alignment: alignment)
    }
    
    func frame(w: FlexibleDimension, h: FlexibleDimension, alignment: Alignment = .center) -> some View {
        frame(minWidth: w.min,
              idealWidth: w.try,
              maxWidth: w.max,
              minHeight: h.min,
              idealHeight: h.try,
              maxHeight: h.max,
              alignment: alignment)
    }
    
    func coversScreen(_ color: Color = .init(UIColor.systemBackground), opacity: CGFloat = 1.0)
    -> some View {
        color.opacity(opacity)
             .ignoresSafeArea()
             .overlay(self)
    }
    
    func border<S>(_ color: S, width: CGFloat = 1, rounded r: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: r)
        return clipShape(roundedRect).overlay(roundedRect.strokeBorder(color, lineWidth: width))
    }
    
    @ViewBuilder func `if`<V:View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> V) -> some View {
        if condition() { transform(self) } else { self }
    }
    
}

public extension Text {
    
    func weight(_ weight: Font.Weight?) -> Text { fontWeight(weight) }
    
}
