/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main tab view of the app.
*/

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.backyards))
        .backyardBirdsDataContainer(inMemory: true)
}
