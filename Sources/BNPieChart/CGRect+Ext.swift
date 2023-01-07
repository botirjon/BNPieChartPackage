//
//  File.swift
//  
//
//  Created by Botirjon Nasridinov on 07/01/23.
//

import Foundation

internal extension CGRect {
    var center: CGPoint {
        .init(x: 0.5*width, y: 0.5*height)
    }
    
    var radius: CGFloat {
        min(0.5*width, 0.5*height)
    }
}
