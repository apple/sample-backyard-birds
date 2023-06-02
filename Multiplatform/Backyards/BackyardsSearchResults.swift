/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard search results.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

struct BackyardsSearchResults: View {
    @Binding var searchText: String
    @Query private var backyards: [Backyard]
    
    init(searchText: Binding<String>) {
        _searchText = searchText
        if searchText.wrappedValue.isEmpty {
            _backyards = Query(sort: \.creationDate)
        } else {
            let term = searchText.wrappedValue
            _backyards = Query(filter: #Predicate { backyard in
                backyard.name.contains(term)
            }, sort: \.name)
        }
    }
    
    var body: some View {
        ForEach(backyards) { backyard in
            BackyardGridItem(backyard: backyard)
        }
    }
}
