/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The detail column of the split view.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("Select a Backyard", systemImage: "bird", description: Text("Pick something from the list."))
            }
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    AppDetailColumn()
        .backyardBirdsDataContainer(inMemory: true)
}
