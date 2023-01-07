//
//  BNPieChartSlice.swift
//  
//
//  Created by Botirjon Nasridinov on 07/01/23.
//

import UIKit

public struct BNPieChartSlice {
    var title: String = ""
    var color: UIColor = .random()
    var weight: Float
    
    internal var share: CGFloat {
        CGFloat(weight)
    }
}
