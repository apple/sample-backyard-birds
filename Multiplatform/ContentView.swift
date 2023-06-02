/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The view that holds the app's visual content.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData
import LayeredArtworkLibrary

struct ContentView: View {
    @State private var selection: AppScreen? = .backyards
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
        .backyardBirdsDataContainer(inMemory: true)
}
