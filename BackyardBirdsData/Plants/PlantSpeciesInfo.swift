/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plant species information.
*/

import Foundation

public struct PlantSpeciesInfo: RawRepresentable, Hashable, CaseIterable, Codable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static var allCases: [PlantSpeciesInfo] = [
        .foxglove, .snakePlant, .colocasia, .kentiaPalm, .alocasia
    ]
    
    public static let foxglove = Self(rawValue: "Plant 1")
    public static let snakePlant = Self(rawValue: "Plant 2") // Snake Plant, Rubber Tree
    public static let colocasia = Self(rawValue: "Plant 3")
    public static let kentiaPalm = Self(rawValue: "Plant 4") // Kentia Palm
    public static let alocasia = Self(rawValue: "Plant 5")
    
    public var name: String {
        switch self {
        case .foxglove:
            String(localized: "Foxglove", table: "PlantSpecies", bundle: .module, comment: "Plant 1 name")
        case .snakePlant:
            String(localized: "Snake Plant", table: "PlantSpecies", bundle: .module, comment: "Plant 2 name")
        case .colocasia:
            String(localized: "Colocasia", table: "PlantSpecies", bundle: .module, comment: "Plant 3 name")
        case .kentiaPalm:
            String(localized: "Kentia Palm", table: "PlantSpecies", bundle: .module, comment: "Plant 4 name")
        case .alocasia:
            String(localized: "Alocasia", table: "PlantSpecies", bundle: .module, comment: "Plant 5 name")
        default:
            fatalError()
        }
    }
    
    public var summary: String {
        switch self {
        case .foxglove:
            String(localized: "Totally tubular flowering stems.", table: "PlantSpecies", bundle: .module, comment: "Plant 1 summary")
        case .snakePlant:
            String(localized: "Much more well behaved than the name implies.", table: "PlantSpecies", bundle: .module, comment: "Plant 2 summary")
        case .colocasia:
            String(localized: "Makes a great substitute for an umbrella.", table: "PlantSpecies", bundle: .module, comment: "Plant 3 summary")
        case .kentiaPalm:
            String(localized: "Quite independent and requires minimal attention.", table: "PlantSpecies", bundle: .module, comment: "Plant 4 summary")
        case .alocasia:
            String(localized: "Loves a good leaf cleaning.", table: "PlantSpecies", bundle: .module, comment: "Plant 5 summary")
        default:
            fatalError()
        }
    }
}
