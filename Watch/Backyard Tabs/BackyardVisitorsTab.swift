/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard visitors tab.
*/

import SwiftUI
import BackyardBirdsData
import BackyardBirdsUI
import LayeredArtworkLibrary

struct BackyardVisitorsTab: View {
    var backyard: Backyard
    
    var body: some View {
        List {
            if let bird = backyard.currentVisitorEvent?.bird {
                Section("Here Now") {
                    HStack {
                        BirdIcon(bird: bird)
                            .frame(width: 60, height: 60)
                        Text(bird.speciesName)
                    }
                }
            }
            
            Section("Recent") {
                RecentBackyardVisitorsView(backyard: backyard)
            }
        }
        .navigationTitle("Visitors")
    }
}
