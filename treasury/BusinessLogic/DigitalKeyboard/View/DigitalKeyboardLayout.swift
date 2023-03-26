//
//  DigitalKeyboardLayout.swift
//  treasury
//
//  Created by sugarbaron on 11.02.2023.
//

import SwiftUI

extension DigitalKeyboard.Ui {
    
    struct KeysLayout : Layout {
        
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
            CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
            let allW: CGFloat = bounds.width
            let allH: CGFloat = bounds.height
            let spacing: Spacing = subviews.spacing
            let columns: Int = 4
            let spacings: Int = columns + 1
            let keyW: CGFloat = (allW - spacings.cgFloat * spacing.w) / columns.cgFloat
            let controlColumns: Int = 1
            let digitColumns: Int = columns - controlColumns
            let digitSpacings: Int = digitColumns - 1
            let digitPanelW:   CGFloat = (digitColumns.cgFloat * keyW) + (digitSpacings.cgFloat * spacing.w)
            let controlPanelW: CGFloat = keyW
            let panelH: CGFloat = allH - 2 * spacing.h
            var x: CGFloat = bounds.minX + spacing.w
            let y: CGFloat = bounds.minY + spacing.h
            subviews.at(0)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: digitPanelW, h: panelH))
            x += (digitPanelW + spacing.w)
            subviews.at(1)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: controlPanelW, h: panelH))
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
            let xSpacings: CGFloat = spacing.w * (columns - 1).cgFloat
            let ySpacings: CGFloat = spacing.h * (rows - 1).cgFloat
            let keyW: CGFloat = (allW - xSpacings) / columns.cgFloat
            let keyH: CGFloat = (allH - ySpacings) / rows.cgFloat
            
            var x: CGFloat = bounds.minX
            var y: CGFloat = bounds.minY
            for row in (0..<(rows - 1)) {
                for column in (0..<columns) {
                    let index: Int = column + (row * columns)
                    subviews.at(index)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: keyW, h: keyH))
                    x += (keyW + spacing.w)
                }
                y += (keyH + spacing.h)
                x = bounds.minX
            }
            subviews.at(zeroKeyIndex)?.place(at: CGPoint(x: x, y: y), proposal: .size(w: allW, h: keyH))
        }
        
    }
    
    struct ControlKeysLayout : Layout {
        
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
            CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
            let enterKeyIndex: Int = 1
            let rows: Int = 4
            let allW: CGFloat = bounds.width
            let allH: CGFloat = bounds.height
            let spacing: Spacing = subviews.spacing
            let ySpacings: CGFloat = spacing.h * (rows - 1).cgFloat
            let keyW: CGFloat = allW
            let keyH: CGFloat = (allH - ySpacings) / rows.cgFloat
            let enterKeyH: CGFloat = (3 * keyH) + (2 * spacing.h)
            
            let x: CGFloat = bounds.minX
            var y: CGFloat = bounds.minY
            subviews.indices.forEach { index in
                let keyH: CGFloat = (index == enterKeyIndex) ? enterKeyH : keyH
                subviews[index].place(at: CGPoint(x: x, y: y), proposal: .size(w: keyW, h: keyH))
                y += (keyH + spacing.h)
            }
        }
        
    }
    
}
