/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The birds navigation stack.
*/

import SwiftData
import BackyardBirdsData
import BackyardBirdsUI
import LayeredArtworkLibrary
import SwiftUI

struct BirdsNavigationStack: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 110), alignment: .top)], spacing: 20) {
                    BirdsSearchResults(searchText: $searchText) { bird in
                        BirdGridItem(bird: bird)
                    }
                }
            }
            .contentMargins(20, for: .scrollContent)
            .navigationTitle("Birds")
            .searchable(text: $searchText)
            .searchSuggestions {
                if searchText.isEmpty {
                    BirdsSearchSuggestions()
                }
            }
        }
    }
}

#Preview {
    BirdsNavigationStack()
        .backyardBirdsDataContainer(inMemory: true)
}
