/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation of bird species data.
*/

import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "BirdSpecies")

extension BirdSpecies {
    static func generateAll(modelContext: ModelContext) {
        logger.info("Generating all bird species")
        
        modelContext.insert(BirdSpecies(
            info: .swallow,
            naturalScale: 0.83,
            parts: [
                .feet(x: 0.58, y: 0.65),
                .body(x: 0.6, y: 0.5),
                .belly,
                .chin,
                .eye(x: 0.7, y: 0.29),
                .beak(x: 0.8, y: 0.3),
                .wing(x: 0.63, y: 0.41)
            ]
        ))
        
        modelContext.insert(BirdSpecies(
            info: .dove,
            naturalScale: 1,
            parts: [
                .feet(),
                .body(),
                .belly,
                .eye(),
                .wing(),
                .beak()
            ]
        ))
        
        modelContext.insert(BirdSpecies(
            info: .chickadee,
            naturalScale: 0.71,
            isEarlyAccess: true,
            parts: [
                .feet(),
                .body(),
                .belly,
                .eye(),
                .beak(),
                .wing()
            ]
        ))
        
        modelContext.insert(BirdSpecies(
            info: .petrel,
            naturalScale: 1,
            parts: [
                .feet(),
                .body(),
                .belly,
                .chin,
                BirdPart(name: "Head", colorStyle: BirdPartColorStyle.black.rawValue),
                .eye(),
                .beak(),
                .wing()
            ]
        ))
        
        modelContext.insert(BirdSpecies(
            info: .cardinal,
            naturalScale: 1,
            parts: [
                .feet(),
                .body(),
                .belly,
                .beak(),
                .eye(),
                .wing()
            ]
        ))
        
        modelContext.insert(BirdSpecies(
            info: .hummingbird,
            naturalScale: 0.76,
            parts: [
                BirdPart(name: "BackWing", colorStyle: BirdPartColorStyle.wing.rawValue, isWing: true, flipbookFrameCount: 2),
                .body(),
                .belly,
                .chin,
                .eye(),
                .beak(),
                BirdPart(name: "FrontWing", colorStyle: BirdPartColorStyle.wing.rawValue, isWing: true, flipbookFrameCount: 2)
            ]
        ))
        
        logger.info("Generated bird species")
    }
}

