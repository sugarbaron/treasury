//
//  Layout.swift
//  treasury
//
//  Created by sugarbaron on 02.08.2021.
//

import SwiftUI

final class Layout {
    
    private static let xSpaceSize: CGFloat = 10
    private static let ySpaceSize: CGFloat = 10
    
    static var xSpace: some View { Spacer().frame(width: xSpaceSize) }
    static var ySpace: some View { Spacer().frame(height: ySpaceSize) }
    static var yTitleSpace: some View { Spacer().frame(height: 3 * ySpaceSize) }
    static var xInfinite: some View { Spacer().frame(maxWidth: .infinity) }
    static var yInfinite: some View { Spacer().frame(maxHeight: .infinity) }
    
}
