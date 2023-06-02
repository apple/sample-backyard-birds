/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation of bird palette data.
*/

import SwiftData

extension BirdPalette {
    static func generateColors(info: BirdSpeciesInfo, random: inout SeededRandomGenerator) -> BirdPalette {
        switch info {
        case .swallow:
            return swallowPalettes.randomElement(using: &random)!
        case .dove:
            return dovePalettes.randomElement(using: &random)!
        case .chickadee:
            return chickadeePalettes.randomElement(using: &random)!
        case .petrel:
            return petrelPalettes.randomElement(using: &random)!
        case .cardinal:
            return cardinalPalettes.randomElement(using: &random)!
        case .hummingbird:
            return hummingbirdPalettes.randomElement(using: &random)!
        default:
            fatalError()
        }
    }
    
    // MARK: - Palettes
    
    static let swallowPalettes: [BirdPalette] = [
        BirdPalette(body: .birdRed, beak: .birdBlack),
        BirdPalette(body: .birdBrown, beak: .birdBlack, belly: .birdBeige, accent: .birdOrange),
        BirdPalette(body: .birdOrange, beak: .birdBlack, accent: .birdBlack),
        BirdPalette(body: .birdDarkBlue, beak: .birdBlack, accent: .birdBlack),
        BirdPalette(body: .birdBlack, beak: .birdBlack, accent: .birdRed),
        BirdPalette(body: .birdWhite, beak: .birdBlack, accent: .birdBlue),
        BirdPalette(body: .birdPurple, beak: .birdBlack, accent: .birdBlack)
    ]

    static let dovePalettes: [BirdPalette] = [
        BirdPalette(body: .birdRed, beak: .birdYellow),
        BirdPalette(body: .birdBrown, beak: .birdBlack, belly: .birdBeige),
        BirdPalette(body: .birdYellow, beak: .birdBlack),
        BirdPalette(body: .birdBlue, wing: .birdWhite, beak: .birdBlack),
        BirdPalette(body: .birdBlack, beak: .birdBlack, belly: .birdBlack),
        BirdPalette(body: .birdWhite, beak: .birdBlack, belly: .birdWhite),
        BirdPalette(body: .birdPurple, beak: .birdBlack, belly: .birdLightPurple)
    ]

    static let chickadeePalettes: [BirdPalette] = [
        BirdPalette(body: .birdRed, beak: .birdYellow),
        BirdPalette(body: .birdBrown, beak: .birdYellow),
        BirdPalette(body: .birdYellow, beak: .birdYellow),
        BirdPalette(body: .birdBlue, wing: .birdBlack, beak: .birdYellow),
        BirdPalette(body: .birdBlack, beak: .birdBlack),
        BirdPalette(body: .birdWhite, beak: .birdYellow),
        BirdPalette(body: .birdPurple, beak: .birdBlack, belly: .birdLightPurple)
    ]

    static let petrelPalettes: [BirdPalette] = [
        BirdPalette(body: .birdRed, beak: .birdYellow, belly: .birdWhite, accent: .birdWhite),
        BirdPalette(body: .birdBrown, beak: .birdYellow, belly: .birdBeige, accent: .birdOrange),
        BirdPalette(body: .birdYellow, beak: .birdYellow, accent: .birdOrange),
        BirdPalette(body: .birdBlue, beak: .birdYellow, accent: .birdBlue),
        BirdPalette(body: .birdBlack, beak: .birdYellow, accent: .birdBlack),
        BirdPalette(body: .birdWhite, beak: .birdYellow, accent: .birdWhite),
        BirdPalette(body: .birdPurple, beak: .birdBlack, belly: .birdLightPurple, accent: .birdPurple)
    ]

    static let cardinalPalettes: [BirdPalette] = [
        BirdPalette(body: .birdRed, beak: .birdYellow, belly: .birdBeige),
        BirdPalette(body: .birdBrown, beak: .birdYellow, belly: .birdBeige),
        BirdPalette(body: .birdYellow, beak: .birdBrown),
        BirdPalette(body: .birdBlue, beak: .birdBlack),
        BirdPalette(body: .birdBlack, beak: .birdBlack, belly: .birdRed),
        BirdPalette(body: .birdWhite, beak: .birdBlack),
        BirdPalette(body: .birdPurple, beak: .birdBlack, belly: .birdLightPurple)
    ]

    static let hummingbirdPalettes: [BirdPalette] = [
        BirdPalette(body: .birdGreen, beak: .birdBlack, belly: .birdLightGreen, accent: .birdPink),
        BirdPalette(body: .birdDarkBlue, beak: .birdBlack, accent: .birdPink),
        BirdPalette(body: .birdYellow, beak: .birdBlack, accent: .birdPink),
        BirdPalette(body: .birdBlack, beak: .birdBlack, accent: .birdPurple),
        BirdPalette(body: .birdPurple, beak: .birdBlack, belly: .birdLightPurple, accent: .birdPurple),
        BirdPalette(body: .birdTeal, beak: .birdBlack, belly: .birdLightGreen, accent: .birdDarkBlue)
    ]
}

// MARK: - Individual Colors

extension ColorData {
    static let birdBeige = ColorData(hue: 28 / 360, saturation: 0.17, brightness: 0.94)
    static let birdBlack = ColorData(hue: 285 / 360, saturation: 0, brightness: 0.29)
    static let birdBlue = ColorData(hue: 212 / 360, saturation: 0.43, brightness: 0.85)
    static let birdBrown = ColorData(hue: 28 / 360, saturation: 0.70, brightness: 0.54)
    static let birdDarkBlue = ColorData(hue: 212 / 360, saturation: 0.64, brightness: 0.80)
    static let birdGray = ColorData(hue: 0 / 360, saturation: 0, brightness: 0.77)
    static let birdGreen = ColorData(hue: 89 / 360, saturation: 0.53, brightness: 0.77)
    static let birdLightGreen = ColorData(hue: 90 / 360, saturation: 0.13, brightness: 0.95)
    static let birdLightPurple = ColorData(hue: 283 / 360, saturation: 0.37, brightness: 0.90)
    static let birdOrange = ColorData(hue: 30 / 360, saturation: 0.81, brightness: 0.94)
    static let birdPink = ColorData(hue: 327 / 360, saturation: 0.48, brightness: 0.91)
    static let birdPurple = ColorData(hue: 283 / 360, saturation: 0.61, brightness: 0.86)
    static let birdRed = ColorData(hue: 353 / 360, saturation: 0.75, brightness: 0.87)
    static let birdTeal = ColorData(hue: 166 / 360, saturation: 0.64, brightness: 0.77)
    static let birdWhite = ColorData(hue: 0 / 360, saturation: 0, brightness: 0.96)
    static let birdYellow = ColorData(hue: 37 / 360, saturation: 0.68, brightness: 0.94)
}
