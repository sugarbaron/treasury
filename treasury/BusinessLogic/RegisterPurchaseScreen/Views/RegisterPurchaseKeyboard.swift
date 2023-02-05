//
//  RegisterPurchaseKeyboard.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import SwiftUI

// MARK: constructor
extension RegisterPurchase {
    
    struct Keyboard { }
    
}

// MARK: layout
extension RegisterPurchase.Keyboard : View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack { Spacer(); display; Spacer() }
            HStack { Spacer(); keys; Spacer() }
            Spacer()
        }
        .background(Color.uprised)
        .rounded(10)
    }
    
    private var display: some View {
        HStack { Spacer(); Text("100500").title().foreground(.regular).lineLimit(1).padding() }
            .background(Color.lowered)
            .border(Color.black, width: 2, rounded: 10)
    }
    
    private var keys: some View {
        KeysLayout {
            DigitKeysLayout {
                key("1"); key("2"); key("3")
                key("4"); key("5"); key("6")
                key("7"); key("8"); key("9")
                          key("0")
            }
            ControlKeysLayout {
                key(undo)
                key(".")
                key(enter)
            }
        }
    }
    
    private func key(_ label: String) -> some View {
        key(Text(label).title().foreground(.regular).lineLimit(1))
    }
    
    private func key(_ label: some View) -> some View {
        Color.background
            .overlay(label)
            .border(Color.lowered, width: 3, rounded: 10)
    }
    
    private var undo: some View {
        Image(systemName: "delete.left").title().foreground(.regular)
    }
    
    private var enter: some View {
        Image(systemName: "arrow.uturn.right").big().rotationEffect(.degrees(180)).foreground(.accent1)
    }
}

struct KeysLayout : Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let allW: CGFloat = bounds.width
        let allH: CGFloat = bounds.height
        let spacing: Spacing = subviews.spacing
        let digitsPanelW:  CGFloat = 0.75 * (allW - spacing.x)
        let controlPanelW: CGFloat = 0.25 * (allW - spacing.x)
        var x: CGFloat = bounds.minX
        let y: CGFloat = bounds.minY
        subviews.at(0)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: digitsPanelW, h: allH))
        x += (digitsPanelW + spacing.x)
        subviews.at(1)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: controlPanelW, h: allH))
    }
    
}

struct DigitKeysLayout : Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let zeroKeyIndex: Int = 9
        guard subviews.count == 10 else { return }
        let columns: Int = 3
        let rows: Int = 4
        let allW: CGFloat = bounds.width
        let allH: CGFloat = bounds.height
        let spacing: Spacing = subviews.spacing
        let xSpacingsW: CGFloat = spacing.x * (columns - 1).cgFloat
        let ySpacingsH: CGFloat = spacing.y * (rows - 1).cgFloat
        let keyW: CGFloat = (allW - xSpacingsW) / columns.cgFloat
        let keyH: CGFloat = (allH - ySpacingsH) / rows.cgFloat
        let zeroKeyW:  CGFloat = (3 * keyW) + (2 * spacing.x)
        
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        for row in (0..<(rows - 1)) {
            for column in (0..<columns) {
                let index: Int = column + (row * columns)
                subviews.at(index)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: keyW, h: keyH))
                x += (keyW + spacing.x)
            }
            y += (keyH + spacing.y)
            x = bounds.minX
        }
        subviews.at(zeroKeyIndex)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: zeroKeyW, h: keyH))
    }
    
}

struct ControlKeysLayout : Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let enterKeyIndex: Int = 2
        let rows: Int = 4
        let allW: CGFloat = bounds.width
        let allH: CGFloat = bounds.height
        let spacing: Spacing = subviews.spacing
        let ySpacingsH: CGFloat = spacing.y * (rows - 1).cgFloat
        let keyW: CGFloat = allW
        let keyH: CGFloat = (allH - ySpacingsH) / rows.cgFloat
        let enterKeyH: CGFloat = (2 * keyH) + spacing.y
        
        let x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        subviews.indices.forEach { index in
            let keyH: CGFloat = (index == enterKeyIndex) ? enterKeyH : keyH
            subviews[index].place(at: CGPoint(x: x, y: y), proposal: .size(w: keyW, h: keyH))
            y += (keyH + spacing.y)
        }
    }
    
}

private extension LayoutSubviews {
    
    var spacing: Layout.Spacing {
        if count < 2 { return (0.0, 0.0) }
        let item0: Element = self[0]
        let item1: Element = self[1]
        let x: CGFloat = item0.spacing.distance(to: item1.spacing, along: .horizontal)
        let y: CGFloat = item0.spacing.distance(to: item1.spacing, along: .vertical)
        return (x, y)
    }
    
    var lastIndex: Int? { (count > 0) ? count - 1 : nil }
    
    func at(_ index: Int?) -> Element? { unwrap(index) { $0.isOne(of: indices) ? self[$0] : nil } }
    
}

private extension ProposedViewSize {
    
    static func size(w: CGFloat, h: CGFloat) -> ProposedViewSize { .init(width: w, height: h) }
    
}

private extension Layout { typealias Spacing = (x: CGFloat, y: CGFloat) }


struct RegisterPurchaseKeyboard_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Keyboard() }
}
