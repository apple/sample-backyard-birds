/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Convenience extensions to Core Graphics entities.
*/

import CoreGraphics

extension CGRect {
    var min: CGPoint {
        CGPoint(x: minX, y: minX)
    }
    
    var mid: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    var max: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
}

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
