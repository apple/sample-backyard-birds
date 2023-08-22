/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plant species.
*/

import Observation
import SwiftData

@Model public class PlantSpecies {
    @Attribute(.unique) public var id: String
    public var parts: [PlantPart]
    
    @Relationship(deleteRule: .cascade, inverse: \Plant.species)
    public var plants: [Plant] = []
    
    public var info: PlantSpeciesInfo {
        PlantSpeciesInfo(rawValue: id)
    }
    
    public init(info: PlantSpeciesInfo, parts: [PlantPart]) {
        self.id = info.rawValue
        self.parts = parts
    }
}
