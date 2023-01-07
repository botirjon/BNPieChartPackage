//
//  File.swift
//  
//
//  Created by Botirjon Nasridinov on 07/01/23.
//

import UIKit

internal extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random())/CGFloat(UInt32.max)
    }
}

internal extension UIColor {
    static func random() -> UIColor {
        return UIColor.init(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
    
