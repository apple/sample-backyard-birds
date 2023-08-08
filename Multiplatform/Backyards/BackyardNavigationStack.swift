/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard navigation stack.
*/

import SwiftUI
import SwiftData
import BackyardBirdsUI
import BackyardBirdsData

struct BackyardNavigationStack: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    var body: some View {
        NavigationStack {
            BackyardGrid()
                .navigationTitle("Backyards")
                .navigationDestination(for: Backyard.ID.self) { backyardID in
                    if let backyard = backyards.first(where: { $0.id == backyardID }) {
                        BackyardDetailView(backyard: backyard)
                            #if os(macOS)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background()
                            #endif
                    }
                }
        }
    }
}

#Preview {
    BackyardNavigationStack()
        .backyardBirdsDataContainer(inMemory: true)
}

