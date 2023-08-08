/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The new bird indicator card view.
*/

import SwiftUI
import SwiftData
import BackyardBirdsUI
import BackyardBirdsData
import LayeredArtworkLibrary

struct NewBirdIndicatorCard: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    var body: some View {
        if let backyard = backyards.first, let bird = backyard.currentVisitorEvent?.bird {
            HStack {
                NewBirdIndicator()
                VStack(alignment: .leading) {
                    Text("\(bird.speciesName) is visiting", comment: "Variable is a bird species")
                        .font(.headline)
                    Text("Arrived in \(backyard.name)", comment: "Variable is a backyard name")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.subheadline.bold())
                    .foregroundStyle(.tertiary)
                    .frame(width: 30)
            }
            .padding(12)
            .background(.fill.tertiary, in: .capsule)
            .frame(maxWidth: 400)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ZStack {
        NewBirdIndicatorCard()
    }
    .padding()
    .backyardBirdsDataContainer(inMemory: true)
}
