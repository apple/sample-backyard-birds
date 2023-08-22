/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird data.
*/

import Observation
import Foundation
import SwiftData
import SwiftUI

@Model public class Bird {
    @Attribute(.unique) public var id: String
    public var creationDate: Date
    
    public var species: BirdSpecies?
    public var favoriteFood: BirdFood?
    public var dislikedFoods: [BirdFood] = []
    public var colors: BirdPalette
    public var tag: String?
    public var lastKnownVisit: Date?
    
    /// The preferred time of day, when shown in the UI.
    public var backgroundTimeInterval: Double
    
    public var speciesName: String { species?.info.name ?? "- Species name is missing. -" }
    public var speciesSummary: String { species?.info.summary ?? "- Species summary is missing. -" }
    
    public var visitStatus: BirdVisitStatus {
        if let lastKnownVisit {
            .recently(lastKnownVisit)
        } else {
            .never
        }
    }
    
    public init(creationDate: Date = .now, colors: BirdPalette, tag: BirdTag? = nil, backgroundTimeInterval: TimeInterval = TimeInterval(hours: 10)) {
        self.id = UUID().uuidString
        self.creationDate = creationDate
        self.colors = colors
        self.tag = tag?.rawValue
        self.backgroundTimeInterval = backgroundTimeInterval
    }
    
    public func updateVisitStatus(visitedOn date: Date) {
        guard date <= .now else { return }
        if let lastKnownVisit, lastKnownVisit > date {
            return
        }
        lastKnownVisit = date
    }
}

public enum BirdTag: String, Hashable, Codable {
    case classicGreenHummingbird
    case premiumGoldenHummingbird
}
