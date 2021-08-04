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
    
}