/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation of bird food data.
*/

import OSLog
import SwiftData

private let logger = Logger(subsystem: "Backyard Birds Data", category: "BirdFood")

extension BirdFood {
    static func generateAll(modelContext: ModelContext) {
        logger.info("Generating all Bird Food...")
        
        logger.info("Nutrition Pellet")
        modelContext.insert(BirdFood(
            id: "Nutrition Pellet",
            name: String(localized: "Nutrition Pellet", table: "BirdFood", bundle: .module),
            summary: String(localized: "A nutritious snack that any bird loves.", table: "BirdFood", bundle: .module),
            products: [
                Product(
                    id: "pellet.single",
                    quantity: 1
                ),
                Product(
                    id: "pellet.box",
                    quantity: 5
                )
            ],
            priority: 3
        ))

        logger.info("Nectar")
        modelContext.insert(BirdFood(
            id: "Nectar",
            name: String(localized: "Nectar", table: "BirdFood", bundle: .module),
            summary: String(localized: "A sweet nectar to draw birds to your backyard.", table: "BirdFood", bundle: .module),
            products: [
                Product(
                    id: "nectar.cup",
                    quantity: 1
                ),
                Product(
                    id: "nectar.bottle",
                    quantity: 5
                )
            ],
            priority: 2
        ))

        logger.info("Golden Acorn")
        modelContext.insert(BirdFood(
            id: "Golden Acorn",
            name: String(localized: "Golden Acorn", table: "BirdFood", bundle: .module),
            summary: String(localized: "Birds crave this golden treat.", table: "BirdFood", bundle: .module),
            products: [
                Product(
                    id: "acorns.individual",
                    quantity: 1
                ),
                Product(
                    id: "acorns.collection",
                    quantity: 5
                )
            ]
        ))
        
        logger.info("Sunflower seeds")
        modelContext.insert(BirdFood(
            id: "Sunflower Seeds",
            name: String(localized: "Sunflower Seeds", table: "BirdFood", bundle: .module),
            summary: String(localized: "A favorite for many backyard visitors.", table: "BirdFood", bundle: .module)
        ))
        
        modelContext.insert(BirdFood(
            id: "Corn",
            name: String(localized: "Corn", table: "BirdFood", bundle: .module),
            summary: String(localized: "Sweet treats for our feathered friends.", table: "BirdFood", bundle: .module)
        ))
        
        modelContext.insert(BirdFood(
            id: "Millet Seeds",
            name: String(localized: "Millet Seeds", table: "BirdFood", bundle: .module),
            summary: String(localized: "Fun fall flavor in every bite.", table: "BirdFood", bundle: .module)
        ))
        
        modelContext.insert(BirdFood(
            id: "Peanuts",
            name: String(localized: "Peanuts", table: "BirdFood", bundle: .module),
            summary: String(localized: "Deshelled peanuts, buttery smooth taste!", table: "BirdFood", bundle: .module)
        ))
        
        modelContext.insert(BirdFood(
            id: "Safflower Seeds",
            name: String(localized: "Safflower Seeds", table: "BirdFood", bundle: .module),
            summary: String(localized: "The bitter rival of sunflower seeds.", table: "BirdFood", bundle: .module)
        ))
        
        modelContext.insert(BirdFood(
            id: "Sorghum Seeds",
            name: String(localized: "Sorghum Seeds", table: "BirdFood", bundle: .module),
            summary: String(localized: "Winter delight to make for a cozy backyard.", table: "BirdFood", bundle: .module)
        ))
        
        for food in try! modelContext.fetch(FetchDescriptor<BirdFood>()) {
            if let quantity = DataGenerationOptions.initialOwnedBirdFoods[food.id] {
                food.ownedQuantity = quantity
            }
        }
        
        logger.info("Completed generating all of the bird food.")
    }
}
