/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plants navigation stack.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

struct PlantsNavigationStack: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), alignment: .top)], spacing: 20) {
                    PlantsSearchResults(searchText: $searchText)
                }
            }
            .searchable(text: $searchText)
            .searchSuggestions {
                if searchText.isEmpty {
                    PlantsSearchSuggestions()
                }
            }
            .contentMargins(20, for: .scrollContent)
            .navigationTitle("Plants")
        }
    }
}

#Preview {
    PlantsNavigationStack()
        .backyardBirdsDataContainer(inMemory: true)
}
