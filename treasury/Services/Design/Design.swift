//
//  Design.swift
//  treasury
//
//  Created by sugarbaron on 25.03.2023.
//

import SwiftUI
import Bumblebee

final class Design {
    
    static let corners: CGFloat = 8
    
    static let depth: Tap.Effect = .border(color: .black, line: 4, corners: Design.corners)
    
    static func depth(_ color: Rgb, line: CGFloat = 4) -> Tap.Effect {
        .border(color: color, line: line, corners: Design.corners)
    }
    
}

extension View {
    
    func design(_ element: Design.Element) -> some View { Group {
        switch element {
        case .border(let color, let line): border(color, line: line, corners: Design.corners)
        case .corners: corners(Design.corners)
        case .shadow: shadow(color: .lowered, radius: 4)
        }
    } }
    
}

extension Design {
    
    enum Element {
        case border(_ color: Color, line: CGFloat = 1)
        case corners
        case shadow
    }
    
}
