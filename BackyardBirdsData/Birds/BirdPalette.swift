/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A palette of colors for different birds.
*/

import Observation
import SwiftData

public struct BirdPalette: Codable {
    public var body: ColorData
    public var wing: ColorData
    public var beak: ColorData
    public var belly: ColorData
    public var accent: ColorData
    
    public init(body: ColorData, wing: ColorData? = nil, beak: ColorData, belly: ColorData = .white, accent: ColorData = .white) {
        self.body = body
        self.wing = wing ?? body
        self.belly = belly
        self.accent = accent
        self.beak = beak
    }
    
    public func colorData(for colorStyleRawValue: Int) -> ColorData {
        let colorStyle = BirdPartColorStyle(rawValue: colorStyleRawValue)
        switch colorStyle {
        case .body: return body
        case .wing: return wing
        case .belly: return belly
        case .accent: return accent
        case .beak: return beak
        case .white: return .white
        case .black: return .birdBlack
        default:
            fatalError("I didn't know a bird had that part!")
        }
    }
}

public struct BirdPartColorStyle: Hashable, Codable {
    var rawValue: Int = 0
    /// The color for a bird's body.
    static let body = Self(rawValue: 0)
    /// A wing of the bird.
    static let wing = Self(rawValue: 1)
    /// A primary supplemental color.
    static let belly = Self(rawValue: 2)
    /// A secondary supplemental color.
    static let accent = Self(rawValue: 3)
    /// A color appropriate for a beak.
    static let beak = Self(rawValue: 4)
    /// An uncolored bird part, like the eyes and feet.
    static let white = Self(rawValue: 5)
    /// A part of the bird that's colored black.
    static let black = Self(rawValue: 6)
    
    static let allCases: [BirdPartColorStyle] = [
        .body, .wing, .belly, .accent, .beak, .white, .black
    ]
}
