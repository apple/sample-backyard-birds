//
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird food picker sheet.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData
import BackyardBirdsUI

struct BirdFoodPickerSheet: View {
    var backyard: Backyard
    
    @Query(sort: [.init(\BirdFood.priority, order: .reverse), .init(\BirdFood.name, comparator: .localizedStandard)])
    private var birdFood: [BirdFood]
    
    @Environment(\.dismiss) private var dismiss
    @State private var presentingBirdFoodShop = false
    
    private let metrics = BirdFoodStoreMetrics.birdFoodStore

    var premiumFood: [BirdFood] {
        birdFood.filter(\.isPremium)
    }
    
    var otherFood: [BirdFood] {
        birdFood.filter { !$0.isPremium }
    }
    
    #if os(watchOS)
    var body: some View {
        NavigationStack {
            List {
                birdFoodShopLink
                Section(header: premiumText) {
                    ForEach(premiumFood) { food in
                        BirdFoodCard(
                            backyard: backyard,
                            food: food,
                            presentingBirdFoodShop: $presentingBirdFoodShop
                        )
                    }
                }
                Section(header: standardText) {
                    ForEach(otherFood) { food in
                        BirdFoodCard(
                            backyard: backyard,
                            food: food,
                            presentingBirdFoodShop: .constant(false)
                        )
                    }
                }
            }
            .navigationTitle("Bird Food")
            .navigationDestination(isPresented: $presentingBirdFoodShop) {
                BirdFoodShop()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    doneButton
                }
            }
        }
    }
    #else
    var body: some View {
        GeometryReader { geometry in
            let cardWidth: CGFloat? = geometry.size.width > 0 ? (min(geometry.size.width * 0.7, 240) - 40) : nil
            
            NavigationStack {
                ScrollView {
                    premiumText
                    birdFoodShopLink
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(premiumFood) { food in
                                BirdFoodCard(
                                    backyard: backyard,
                                    food: food,
                                    presentingBirdFoodShop: $presentingBirdFoodShop
                                )
                                .frame(width: cardWidth)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                    
                    standardText
                        .padding(.top)
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(otherFood) { food in
                                BirdFoodCard(
                                    backyard: backyard,
                                    food: food,
                                    presentingBirdFoodShop: .constant(false)
                                )
                                .frame(width: cardWidth)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                }
                .navigationTitle("Bird Food")
                .contentMargins([.top, .horizontal], 20, for: .scrollContent)
                .contentMargins(.bottom, 40, for: .scrollContent)
                .navigationDestination(isPresented: $presentingBirdFoodShop) {
                    BirdFoodShop()
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        doneButton
                    }
                }
            }
        }
    }
    #endif
    
    func sectionHeader(_ text: LocalizedStringKey, comment: StaticString) -> some View {
        Text(text, comment: comment)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline.bold())
            .foregroundStyle(.tertiary)
    }
    
    var doneButton: some View {
        Button("Done", action: dismiss.callAsFunction)
            #if os(watchOS)
            .buttonStyle(.plain)
            #endif
    }
    
    var premiumText: some View {
        sectionHeader("Premium", comment: "Refers to a premium bird food item versus standard bird food item.")
    }
    
    var standardText: some View {
        sectionHeader("Standard", comment: "Refers to a premium bird food item versus standard bird food item.")
    }
    
    var birdFoodShopLink: some View {
        Button {
            presentingBirdFoodShop = true
        } label: {
            HStack(spacing: 12) {
                Label("Bird Food Shop", systemImage: "storefront")
                #if !os(watchOS)
                Spacer()
                #endif
                Image(systemName: "chevron.forward")
                    .imageScale(.medium)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tertiary)
            }
            #if os(watchOS)
            .labelStyle(.titleOnly)
            #else
            .imageScale(.large)
            #endif
            .controlSize(metrics.card.controlSize)

        }
        #if !os(watchOS)
        .tint(.premiumBirdFood)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        #endif
    }
    
    struct BirdFoodCard: View {
        var backyard: Backyard
        var food: BirdFood
        @Binding var presentingBirdFoodShop: Bool
        private let metrics = BirdFoodStoreMetrics.birdFoodStore
        
        var needsMore: Bool {
            food.isPremium && food.ownedQuantity <= 0
        }
        
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: metrics.card.verticalSpacing) {
                food.image
                    .scaledToFit()
                    .padding(metrics.food.imagePadding)
                    .frame(width: metrics.food.imageWidth, height: metrics.food.imageHeight)
                    .background(.fill.tertiary, in: .circle)
                    #if os(watchOS)
                    .alignmentGuide(.bottom) { $0[VerticalAlignment.center] + 28 }
                    .alignmentGuide(.trailing) { $0[.trailing] + 3 }
                    #endif
                    .overlay(alignment: .bottomTrailing) {
                        if food.isPremium {
                            BirdFoodQuantityBadge(count: food.ownedQuantity)
                                .font(metrics.food.imageQuantityBadgeFont)
                                #if !os(watchOS)
                                .alignmentGuide(.bottom) { $0[VerticalAlignment.center] - 10 }
                                .alignmentGuide(.trailing) { $0[.trailing] - 30 }
                                #endif
                        }
                    }
                
                VStack {
                    Text(food.name)
                        .font(metrics.food.nameFont)
                    
                    Text(food.summary)
                        #if !os(watchOS)
                        .lineLimit(2, reservesSpace: true)
                        #endif
                        .foregroundStyle(.secondary)
                        .font(metrics.food.summaryFont)
                }
                .multilineTextAlignment(.center)
                
                Button {
                    if needsMore {
                        presentingBirdFoodShop = true
                    } else {
                        withAnimation(.default.delay(0.35)) {
                            backyard.birdFood = food
                            backyard.foodRefillDate = .now
                        }
                        dismiss()
                    }
                } label: {
                    if needsMore {
                        Text("Shop", comment: "Label on button that leads to Bird Food Shop.")
                    } else if food.isPremium {
                        HStack(spacing: metrics.cardActionButton.horizontalSpacing) {
                            Text("Use", comment: "Refers to Premium Food.")
                            Text(1.formatted())
                                #if !os(watchOS)
                                .font(.callout)
                                #endif
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .frame(minWidth: metrics.cardActionButton.minWidth)
                                .foregroundStyle(.premiumBirdFood)
                                .background(.foreground, in: .capsule.inset(by: metrics.cardActionButton.backgroundInset))
                        }
                    } else {
                        Text("Choose", comment: "Refers to Standard Food.")
                    }
                }
                #if os(watchOS)
                .font(.system(size: 12))
                #endif
                .controlSize(metrics.card.controlSize)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(food.isPremium ? .premiumBirdFood : nil)
            }
            .padding(.horizontal, metrics.card.horizontalPadding)
            .padding(.vertical, metrics.card.verticalPadding)
            #if !os(watchOS)
            .frame(maxWidth: .infinity)
            .background(.fill.tertiary, in: .rect(cornerRadius: 20))
            #endif
        }
    }
}

#Preview {
    ModelPreview { backyard in
        BirdFoodPickerSheet(backyard: backyard)
    }
}
