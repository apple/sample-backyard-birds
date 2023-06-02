/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The result of eating particular bird food.
*/

import Foundation
import SwiftUI

public struct BirdEatFoodResult {
    public var bird: Bird
    public var food: BirdFood
    public var enjoyment: Enjoyment
    
    public init(bird: Bird, food: BirdFood) {
        self.bird = bird
        self.food = food
        
        if food.isPremium {
            enjoyment = .enjoy
        } else if bird.favoriteFood == food {
            enjoyment = .favorite
        } else if bird.dislikedFoods.first(where: { $0.id == food.id }) != nil {
            enjoyment = .dislike
        } else {
            enjoyment = .neutral
        }
    }
    
    public enum Enjoyment {
        case dislike
        case neutral
        case enjoy
        case favorite
    }
}

// MARK: - Localized Title & Icon

public extension BirdEatFoodResult {
    var title: String {
        switch enjoyment {
        case .dislike:
            String(
                localized: "\(bird.speciesName) did not like \(food.name)...",
                table: "BirdFood",
                bundle: .module,
                comment: "The first variable is a bird name, and the second variable is a food name. Shown after a bird eats food they didn't like."
            )
        case .neutral:
            String(
                localized: "\(bird.speciesName) had no opinion on \(food.name).",
                table: "BirdFood",
                bundle: .module,
                comment: """
                    The first variable is a bird name, and the second variable is a food name. Shown after a bird eats food they liked or disliked.
                """
            )
        case .enjoy:
            String(
                localized: "\(bird.speciesName) enjoyed \(food.name)!",
                table: "BirdFood",
                bundle: .module,
                comment: "The first variable is a bird name, and the second variable is a food name. Shown after a bird eats food they liked."
            )
        case .favorite:
            String(
                localized: "\(bird.speciesName) loved \(food.name)!",
                table: "BirdFood",
                bundle: .module,
                comment: "The first variable is a bird name, and the second variable is a food name. Shown after a bird eats their favorite food."
            )
        }
    }
    
    var icon: Image {
        switch enjoyment {
        case .dislike:
            Image(systemName: "hand.thumbsdown")
        case .neutral:
            Image(systemName: "zzz")
        case .enjoy:
            Image(systemName: "hand.thumbsup")
        case .favorite:
            Image(systemName: "heart")
        }
    }
}
