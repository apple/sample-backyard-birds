/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The sidebar list.
*/

import SwiftUI

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Backyard Birds")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.backyards))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
    .backyardBirdsDataContainer(inMemory: true)
}
