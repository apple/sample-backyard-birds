/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird species info.
*/

import Foundation

public struct BirdSpeciesInfo: RawRepresentable, Hashable, CaseIterable, Codable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static var allCases: [BirdSpeciesInfo] = [
        .swallow, .dove, .chickadee, .petrel, .cardinal, .hummingbird
    ]
    
    public static let swallow = Self(rawValue: "Bird 1")
    public static let dove = Self(rawValue: "Bird 2")
    public static let chickadee = Self(rawValue: "Bird 3")
    public static let petrel = Self(rawValue: "Bird 4")
    public static let cardinal = Self(rawValue: "Bird 5")
    public static let hummingbird = Self(rawValue: "Bird 6")
    
    public var name: String {
        switch self {
        case .swallow:
            String(localized: "Swallow", table: "Birds", bundle: .module, comment: "Bird 1 name")
        case .dove:
            String(localized: "Dove", table: "Birds", bundle: .module, comment: "Bird 2 name")
        case .chickadee:
            String(localized: "Chickadee", table: "Birds", bundle: .module, comment: "Bird 3 name")
        case .petrel:
            String(localized: "Petrel", table: "Birds", bundle: .module, comment: "Bird 4 name")
        case .cardinal:
            String(localized: "Cardinal", table: "Birds", bundle: .module, comment: "Bird 5 name")
        case .hummingbird:
            String(localized: "Hummingbird", table: "Birds", bundle: .module, comment: "Bird 6 name")
        default:
            fatalError()
        }
    }
    
    public var summary: String {
        switch self {
        case .swallow:
            String(localized: "A cutie, common to many a backyard.", table: "Birds", bundle: .module, comment: "Bird 1 summary")
        case .dove:
            String(localized: "Happy to eat just about anything.", table: "Birds", bundle: .module, comment: "Bird 2 summary")
        case .chickadee:
            String(localized: "Particularly picky about its food.", table: "Birds", bundle: .module, comment: "Bird 3 summary")
        case .petrel:
            String(localized: "Enjoys a good backyard fountain.", table: "Birds", bundle: .module, comment: "Bird 4 summary")
        case .cardinal:
            String(localized: "Loud and proud, with amazing style.", table: "Birds", bundle: .module, comment: "Bird 5 summary")
        case .hummingbird:
            String(localized: "Frequent flier amongst the flowers.", table: "Birds", bundle: .module, comment: "Bird 6 summary")
        default:
            fatalError()
        }
    }
}
