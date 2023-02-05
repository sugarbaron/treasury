//
//  Screen.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import UIKit

public final class Screen {

    public static var width : CGFloat { UIScreen.main.bounds.width  }

    public static var height: CGFloat { UIScreen.main.bounds.height }

    public static var center: CGPoint { CGPoint(x: width * 0.5, y: height * 0.5) }

    public static var isPortrait : Bool { height > width }

    public static var isLandscape: Bool { isPortrait == false }

    public static var greaterDimension: CGFloat { max(width, height) }

    public static var lowerDimension: CGFloat { min(width, height) }
    
}
