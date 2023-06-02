/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard summary tab.
*/

import SwiftUI
import BackyardBirdsUI
import BackyardBirdsData
import LayeredArtworkLibrary

struct BackyardSummaryTab: View {
    var backyard: Backyard
    
    var body: some View {
        VStack {
            if let bird = backyard.currentVisitorEvent?.bird {
                ComposedBird(bird: bird)
                    .frame(width: 80, height: 80)
                Text(bird.speciesName)
                    .font(.headline.bold())
            }
            
            Text("\(2) others recently", comment: "The variable is the number of birds that visited.")
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Label("Water", systemImage: "cup.and.saucer.fill")
                .foregroundStyle(.blue)
            Label("Sunflower seeds", systemImage: "fork.knife")
                .foregroundStyle(.yellow)
        }
        .tint(.teal)
        .navigationTitle("Summary")
        .containerBackground(.teal.gradient, for: .tabView)
    }
}
