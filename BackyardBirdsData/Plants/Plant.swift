/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plant data.
*/

import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "Backyard Birds Data", category: "Plant")

@Model public class Plant {
    @Attribute(.unique) public var id: String
    public var creationDate: Date
    public var species: PlantSpecies?
    public var backyard: Backyard?
    public var variant: Int
    
    public var speciesName: String { species?.info.name ?? "- Plant species name is missing. -" }
    public var speciesSummary: String { species?.info.summary ?? "- Plant species summary is missing. -" }
    
    public init(id: UUID = UUID(), variant: Int) {
        self.id = id.uuidString
        self.creationDate = .now
        self.variant = variant
    }
}
