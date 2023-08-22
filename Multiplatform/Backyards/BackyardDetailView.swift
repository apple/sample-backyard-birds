/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard detail view.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData
import BackyardBirdsUI

struct BackyardDetailView: View {
    var backyard: Backyard
    
    @State private var presentingHappinessIndicator = false
    @State private var presentingBirdFoodShop = false
    
    var body: some View {
        ScrollView {
            BackyardViewport(backyard: backyard)
                .containerShape(.rect(cornerRadius: 20))
                .overlay(alignment: .bottom) {
                    if let bird = backyard.currentVisitorEvent?.bird {
                        if presentingHappinessIndicator {
                            BirdFoodHappinessIndicator(birdName: bird.speciesName, foodName: backyard.birdFood?.name ?? "")
                        }
                    }
                }
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 400))]) {
                BackyardSupplyIndicator(backyard: backyard, supplies: .food)
                BackyardSupplyIndicator(backyard: backyard, supplies: .water)
            }
            
            Text("Recent Visitors")
                .font(.subheadline.bold())
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            LazyVStack {
                RecentBackyardVisitorsView(backyard: backyard)
            }
        }
        .onChange(of: backyard.foodRefillDate) { (_, _) in
            withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
                presentingHappinessIndicator = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                    presentingHappinessIndicator = false
                }
            }
        }
        .contentMargins(20, for: .scrollContent)
        .navigationTitle(backyard.name)
        .toolbar {
            ToolbarItem {
                Button {
                    backyard.isFavorite.toggle()
                } label: {
                    Label("Favorite", systemImage: "star")
                        .symbolVariant(backyard.isFavorite ? .fill : .none)
                }
            }
        }
    }
}

#Preview {
    ModelPreview { backyard in
        NavigationStack {
            BackyardDetailView(backyard: backyard)
        }
    }
}
