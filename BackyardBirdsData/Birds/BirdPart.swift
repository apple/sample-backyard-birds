/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The parts of a bird's anatomy.
*/

import Foundation

public struct BirdPart: Identifiable, Codable {
    public var id: String { name }
    public var name: String
    public var colorStyle: Int = BirdPartColorStyle.body.rawValue
    public var pivotX: Double?
    public var pivotY: Double?
    public var isBody: Bool = false
    public var isEye: Bool = false
    public var isWing: Bool = false
    public var flipbookFrameCount: Int?
    public var chance: Double?
    
    static func feet(x: Double? = nil, y: Double? = nil) -> BirdPart {
        BirdPart(name: "Feet", colorStyle: BirdPartColorStyle.white.rawValue, pivotX: x, pivotY: y)
    }
    
    static func body(x: Double? = nil, y: Double? = nil) -> BirdPart {
        BirdPart(name: "Body", colorStyle: BirdPartColorStyle.body.rawValue, pivotX: x, pivotY: y, isBody: true)
    }
    
    static var belly: BirdPart {
        BirdPart(name: "Belly", colorStyle: BirdPartColorStyle.belly.rawValue)
    }
    
    static var chin: BirdPart {
        BirdPart(name: "Chin", colorStyle: BirdPartColorStyle.accent.rawValue)
    }
    
    static func eye(x: Double? = nil, y: Double? = nil) -> BirdPart {
        BirdPart(name: "Eye", colorStyle: BirdPartColorStyle.white.rawValue, pivotX: x, pivotY: y, isEye: true)
    }
    
    static func beak(x: Double? = nil, y: Double? = nil) -> BirdPart {
        BirdPart(name: "Beak", colorStyle: BirdPartColorStyle.beak.rawValue, pivotX: x, pivotY: y)
    }
    
    static func wing(x: Double? = nil, y: Double? = nil) -> BirdPart {
        BirdPart(name: "Wing", colorStyle: BirdPartColorStyle.wing.rawValue, pivotX: x, pivotY: y, isWing: true)
    }
}
