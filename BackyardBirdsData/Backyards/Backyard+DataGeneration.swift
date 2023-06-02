/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Generates the backyard data.
*/

import OSLog
import SwiftData

private let logger = Logger(subsystem: "BackyardBirdsData", category: "Backyard")

extension Backyard {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 8)
        
        logger.info("Generating all backyards")
        let allPlantSpecies = try! modelContext.fetch(FetchDescriptor<PlantSpecies>(sortBy: [.init(\.id)]))
        let allBirdFood = try! modelContext.fetch(FetchDescriptor<BirdFood>(sortBy: [.init(\.id)]))
        
        logger.info("Generating first backyard")
        let backyard1 = Backyard(name: String(localized: "Bird Springs", table: "Backyards", bundle: .module))
        modelContext.insert(backyard1)
        backyard1.isFavorite = true
        backyard1.birdFood = allBirdFood.first(where: { $0.id == "Sunflower Seeds" })!
        backyard1.timeIntervalOffset = TimeInterval(hours: 8)
        backyard1.leadingPlants = [
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
        ]
        backyard1.trailingPlants = [
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
        ]
        if DataGenerationOptions.firstBackyardLowOnWater {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.water.durationUntilLow)
        } else {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.water.durationUntilLow * 0.6)
        }
        backyard1.foodRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.food.durationUntilLow * 0.33)
        backyard1.floorVariant = .random(in: 0..<4, using: &random)
        backyard1.fountainVariant = .random(in: 0..<3, using: &random)
        backyard1.leadingSilhouetteVariant = .random(in: 0..<10, using: &random)
        backyard1.trailingSilhouetteVariant = .random(in: 0..<10, using: &random)
        
        logger.info("generating remaining backyards")
        func generateRandomBackyard(name: String, timeOffset: Double) {
            let backyard = Backyard(name: name)
            modelContext.insert(backyard)
            backyard.birdFood = allBirdFood.randomElement(using: &random)!
            backyard.timeIntervalOffset = timeOffset
            backyard.leadingPlants = (0..<3).map { _ in
                .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
            }
            
            backyard.trailingPlants = (0..<3).map { _ in
                .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
            }
            backyard.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.water.durationUntilLow *
                .random(in: 0.25 ..< 0.75, using: &random))
            backyard.foodRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.food.durationUntilLow * .random(in: 0.25 ..< 0.75, using: &random))
            backyard.floorVariant = .random(in: 0..<4, using: &random)
            backyard.fountainVariant = .random(in: 0..<3, using: &random)
            backyard.leadingSilhouetteVariant = .random(in: 0..<10, using: &random)
            backyard.trailingSilhouetteVariant = .random(in: 0..<10, using: &random)
        }
        
        generateRandomBackyard(name: String(localized: "Feathered Friends", table: "Backyards", bundle: .module), timeOffset: TimeInterval(hours: 12))
        generateRandomBackyard(name: String(localized: "Calm Palms", table: "Backyards", bundle: .module), timeOffset: TimeInterval(hours: 20))
        generateRandomBackyard(name: String(localized: "Chirp Center", table: "Backyards", bundle: .module), timeOffset: TimeInterval(hours: 21))
        generateRandomBackyard(name: String(localized: "Quiet Haven", table: "Backyards", bundle: .module), timeOffset: TimeInterval(hours: 6))
        
        logger.info("Backyards generated")
    }
}
