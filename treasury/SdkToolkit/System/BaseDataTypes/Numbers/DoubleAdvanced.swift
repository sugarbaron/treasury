//
//  DoubleAdvanced.swift
//  ios-b2field
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation


public extension Double {

    func isSame(as another: Double) -> Bool { fabs(self - another) < Double.ulpOfOne }

    var int: Int { .init(self) }

    var string: String { .init(format: "%03.6f", self) }

}

public extension CGFloat {
    
    var string: String { .init(format: "%03.6f", self) }
    
}
