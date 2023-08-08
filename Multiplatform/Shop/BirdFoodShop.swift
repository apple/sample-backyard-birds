/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird food store view.
*/

import SwiftUI
import StoreKit
import SwiftData

import BackyardBirdsData
import BackyardBirdsUI

struct BirdFoodShop: View {
    @Query(sort: [.init(\BirdFood.name, comparator: .localizedStandard)])
    private var allBirdFood: [BirdFood]
    
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        shopContent
            .background(.background.secondary)
            .navigationTitle("Bird Food Shop")
            #if !os(watchOS)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Done", systemImage: "xmark")
                    }
                    .labelStyle(.titleOnly)
                }
            }
            #endif
    }
    
    #if os(watchOS)
    var shopContent: some View {
        StoreView(ids: productIDs) { product in
            if let (food, product) = birdFood(for: product.id) {
                BirdFoodProductIcon(birdFood: food, quantity: product.quantity)
            }
        }
        .storeButton(.hidden, for: .cancellation)
    }
    #else
    var shopContent: some View {
        ScrollView {
            VStack(spacing: 10) {
                if let (birdFood, product) = bestValue {
                    ProductView(id: product.id) {
                        BirdFoodProductIcon(birdFood: birdFood, quantity: product.quantity)
                            .bestBirdFoodValueBadge()
                    }
                    .padding(.vertical)
                    .background(.background.secondary, in: .rect(cornerRadius: 20))
                    .productViewStyle(.large)
                    .padding()
                    
                    Text("Other Bird Food")
                        .font(.title3.weight(.medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                }
                
                ForEach(premiumBirdFood) { birdFood in
                    BirdFoodShopShelf(title: birdFood.name) {
                        ForEach(birdFood.orderedProducts) { product in
                            ProductView(id: product.id) {
                                BirdFoodProductIcon(birdFood: birdFood, quantity: product.quantity)
                            }
                        }
                    }
                }
            }
            .scrollClipDisabled()
        }
        .contentMargins(.horizontal, 20, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
    #endif
    
    private var premiumBirdFood: [BirdFood] {
        allBirdFood
            .filter(\.isPremium)
            .sorted { lhs, rhs in
                lhs.priority > rhs.priority
            }
    }
    
    private var bestValue: (BirdFood, BirdFood.Product)? {
        allBirdFood
            .first { $0.id == "Nutrition Pellet" }
            .flatMap { nutritionPellet in
                nutritionPellet.products.max { lhs, rhs in
                    lhs.quantity < rhs.quantity
                }
                .map {
                    (nutritionPellet, $0)
                }
            }
    }
    
    private var productIDs: some Collection<Product.ID> {
        allBirdFood.lazy
            .flatMap(\.orderedProducts)
            .map(\.id)
    }
    
    private func birdFood(for productID: Product.ID) -> (BirdFood, BirdFood.Product)? {
        allBirdFood.birdFood(for: productID)
    }
    
}

#Preview {
    NavigationStack {
        ZStack {
            BirdFoodShop()
        }
    }
    .backyardBirdsDataContainer(inMemory: true)
}
