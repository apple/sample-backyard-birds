/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The parts of a plant.
*/

import Foundation

public struct PlantPart: Identifiable, Codable {
    public var id: String { name }
    public var name: String
    public var pivotX: Double? = nil
    public var pivotY: Double? = nil
    public var variants: Int? = nil
    
    public init(name: String, pivotX: Double? = nil, pivotY: Double? = nil, variants: Int? = nil) {
        self.name = name
        self.pivotX = pivotX
        self.pivotY = pivotY
        self.variants = variants
    }
    
    static func pot(x: Double? = nil, y: Double? = nil) -> PlantPart {
        PlantPart(name: "Pot", pivotX: x, pivotY: y)
    }
    
    static func plant(x: Double? = nil, y: Double? = nil, variants: Int = 4) -> PlantPart {
        PlantPart(name: "Variant", pivotX: x, pivotY: y, variants: variants)
    }
}
