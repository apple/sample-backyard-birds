/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard grid.
*/

import SwiftUI
import SwiftData
import BackyardBirdsUI
import BackyardBirdsData

struct BackyardGrid: View {
    @State private var searchText = ""
    
    @Environment(\.passStatus) private var passStatus
    @Environment(\.passStatusIsLoading) private var passStatusIsLoading
    
    @Query var backyards: [Backyard]
    
    var body: some View {
        ScrollView {
            if presentingNewBirdIndicatorCard {
                NewBirdIndicatorCard()
            }
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 300))]) {
                BackyardsSearchResults(searchText: $searchText)
            }
        }
        #if os(macOS)
        .contentMargins(10, for: .scrollContent)
        #else
        .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
        #endif
        .searchable(text: $searchText)
        .searchSuggestions {
            if searchText.isEmpty {
                BackyardsSearchSuggestions()
            }
        }
    }
    
    var backyardsLimit: Int { PassStatus.notSubscribed.backyardLimit ?? 0 }
    
    var canPresentSubscriptionOfferCard: Bool {
        if case .notSubscribed = passStatus, !passStatusIsLoading {
            return true
        }
        return false
    }
    
    var presentingNewBirdIndicatorCard: Bool {
        DataGenerationOptions.showNewBirdIndicatorCard
    }
}

#Preview {
    NavigationStack {
        BackyardGrid()
            .navigationTitle("Backyards")
        #if os(macOS)
            .frame(width: 700, height: 300, alignment: .center)
        #endif
    }
    .backyardBirdsDataContainer(inMemory: true)
}
