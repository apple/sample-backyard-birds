/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Metrics for use in the store.
*/

import SwiftUI

struct BirdFoodStoreMetrics {
    let card: Card
    let cardActionButton: CardActionButton
    let food: Food
    
    struct Food {
        let imageHeight: CGFloat
        let imagePadding: CGFloat
        let imageQuantityBadgeFont: Font
        let imageWidth: CGFloat
        let nameFont: Font
        let summaryFont: Font
        
        #if os(watchOS)
        static let food = BirdFoodStoreMetrics.Food(
            imageHeight: 55,
            imagePadding: 2.5,
            imageQuantityBadgeFont: .system(size: 12),
            imageWidth: 55,
            nameFont: .caption.weight(.semibold),
            summaryFont: .system(size: 10)
        )
        #else
        static let food = BirdFoodStoreMetrics.Food(
            imageHeight: 100,
            imagePadding: 10,
            imageQuantityBadgeFont: .body,
            imageWidth: 100,
            nameFont: .title3.weight(.semibold),
            summaryFont: .callout
        )
        #endif
    }
    
    struct Card {
        let badgeQuantityMinWidth: CGFloat
        let controlSize: ControlSize
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let verticalSpacing: CGFloat
        
        #if os(watchOS)
        static let card = BirdFoodStoreMetrics.Card(
            badgeQuantityMinWidth: 18,
            controlSize: .mini,
            horizontalPadding: 10,
            verticalPadding: 10,
            verticalSpacing: 5
        )
        #else
        static let card = BirdFoodStoreMetrics.Card(
            badgeQuantityMinWidth: 25,
            controlSize: .large,
            horizontalPadding: 20,
            verticalPadding: 40,
            verticalSpacing: 24
        )
        #endif
    }
    
    struct CardActionButton {
        let backgroundInset: CGFloat
        let horizontalSpacing: CGFloat
        let minWidth: CGFloat
        
        #if os(watchOS)
        static let cardActionButton = BirdFoodStoreMetrics.CardActionButton(
            backgroundInset: -2,
            horizontalSpacing: 5,
            minWidth: 15
        )
        #else
        static let cardActionButton = BirdFoodStoreMetrics.CardActionButton(
            backgroundInset: -3,
            horizontalSpacing: 10,
            minWidth: 20
        )
        #endif
    }
    
    static let birdFoodStore = BirdFoodStoreMetrics(
        card: BirdFoodStoreMetrics.Card.card,
        cardActionButton: BirdFoodStoreMetrics.CardActionButton.cardActionButton,
        food: BirdFoodStoreMetrics.Food.food
    )
}
