/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The shelf in the bird food store.
*/

import StoreKit
import SwiftUI
import SwiftData

import BackyardBirdsData

struct BirdFoodShopShelf<Content: View>: View {
    var title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    content
                        #if !os(watchOS)
                        .frame(idealHeight: 130)
                        #endif
                        .padding(12)
                        .frame(width: 300, alignment: .leading)
                        .background(.background.secondary, in: .rect(cornerRadius: 20))
                }
                .scrollTargetLayout()
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }

}

#Preview {
    MyPreview()
}

private struct MyPreview: View {
    @Query(filter: #Predicate<BirdFood> { $0.id == "Nutrition Pellet" })
    private var birdFood: [BirdFood]

    var body: some View {
        ZStack {
            if let birdFood = birdFood.first {
                BirdFoodShopShelf(title: birdFood.name) {
                    ForEach(birdFood.products) { product in
                        ProductView(id: product.id) {
                            BirdFoodProductIcon(birdFood: birdFood, quantity: product.quantity)
                        }
                    }
                }
            }
        }
        .backyardBirdsDataContainer(inMemory: true)
    }
}
