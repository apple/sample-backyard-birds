/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation of plant species data.
*/

import SwiftData

// MARK: - Individual Species

extension PlantSpecies {
    static func generateAll(modelContext: ModelContext) {
        modelContext.insert(PlantSpecies(
            info: .foxglove,
            parts: [
                .pot(),
                .plant()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .snakePlant,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .colocasia,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .kentiaPalm,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .alocasia,
            parts: [
                .plant(),
                .pot()
            ]
        ))
    }
}
