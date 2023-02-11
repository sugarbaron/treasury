//
//  DigitalKeyboardLayout.swift
//  treasury
//
//  Created by sugarbaron on 11.02.2023.
//

import SwiftUI

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
