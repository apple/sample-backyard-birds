/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard search suggestions.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

struct BackyardsSearchSuggestions: View {
    @Query private var backyards: [Backyard]
    
    var events: [BackyardVisitorEvent] {
        Set(backyards.compactMap(\.currentVisitorEvent))
            .sorted { ($0.backyard?.name ?? "") < ($1.backyard?.name ?? "") }
            .sorted { ($0.bird?.speciesName ?? "") < ($1.bird?.speciesName ?? "") }
    }
    
    var body: some View {
        ForEach(events) { event in
            let backyardName = event.backyard?.name ?? "- Event without a backyard. -"
            let speciesName = event.bird?.speciesName ?? "- Species name missing. -"
            Text("**\(speciesName)** is currently in **\(backyardName)**")
                .searchCompletion(backyardName)
        }
    }
}
