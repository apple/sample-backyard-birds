/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation of bird data.
*/

import Foundation
import SwiftData

extension Bird {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 1)
        
        let allBirdFoods = try! modelContext.fetch(FetchDescriptor<BirdFood>(sortBy: [.init(\.id)]))
        let allBirdSpecies = try! modelContext.fetch(FetchDescriptor<BirdSpecies>(sortBy: [.init(\.id)]))
        
        let hummingbirdSpecies = allBirdSpecies.first(where: { $0.info == .hummingbird })!
        
        do {
            let bird = Bird(
                creationDate: .init(timeIntervalSinceNow: -5),
                colors: .hummingbirdPalettes[0],
                tag: .classicGreenHummingbird,
                backgroundTimeInterval: TimeInterval(hours: 12)
            )
            modelContext.insert(bird)
            bird.species = hummingbirdSpecies
            bird.favoriteFood = allBirdFoods.randomElement(using: &random)!
        }
        
        do {
            let bird = Bird(
                creationDate: .init(timeIntervalSinceNow: -3),
                colors: .hummingbirdPalettes[2],
                tag: .premiumGoldenHummingbird,
                backgroundTimeInterval: TimeInterval(hours: 12)
            )
            modelContext.insert(bird)
            bird.species = hummingbirdSpecies
            bird.favoriteFood = allBirdFoods.randomElement(using: &random)!
        }
        
        for species in allBirdSpecies {
            generateBird(species: species)
        }
        
        for species in allBirdSpecies {
            let total = Int.random(in: 5..<8, using: &random)
            for _ in 0 ..< total {
                generateBird(species: species)
            }
        }
        
        func generateBird(species: BirdSpecies) {
            let favoriteFood = allBirdFoods.randomElement(using: &random)!
            var dislikedFoods: [BirdFood] = []
            let totalUnfavored = Int.random(in: 0..<3, using: &random)
            var remainingFood = allBirdFoods
            remainingFood.removeAll(where: { $0.id == favoriteFood.id })
            for _ in 0 ..< totalUnfavored {
                let food = remainingFood.randomElement(using: &random)!
                dislikedFoods.append(food)
                remainingFood.removeAll(where: { $0.id == food.id })
            }
            let bird = Bird(
                colors: .generateColors(info: species.info, random: &random),
                backgroundTimeInterval: .random(in: 0..<TimeInterval(days: 1), using: &random)
            )
            modelContext.insert(bird)
            bird.species = species
            bird.favoriteFood = favoriteFood
            bird.dislikedFoods = dislikedFoods
        }
    }
}
