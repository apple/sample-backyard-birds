/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plant search suggestions.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

struct PlantsSearchSuggestions: View {
    @Query private var plants: [Plant]
    
    var speciesNames: [String] {
        Set(plants.map(\.speciesName)).sorted()
    }
    
    var body: some View {
        ForEach(speciesNames, id: \.self) { speciesName in
            Text("**\(speciesName)**")
                .searchCompletion(speciesName)
        }
    }
}
