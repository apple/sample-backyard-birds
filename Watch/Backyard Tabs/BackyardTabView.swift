/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard tab view.
*/

import SwiftUI
import BackyardBirdsData
import SwiftData

struct BackyardTabView: View {
    var backyard: Backyard
    
    var body: some View {
        TabView {
            BackyardSummaryTab(backyard: backyard)
                .tabItem { Text("Summary") }
            
            BackyardContentTab(backyard: backyard)
                .tabItem { Text("Content") }
            
            BackyardVisitorsTab(backyard: backyard)
                .tabItem { Text("Visitors") }
        }
        .tabViewStyle(.carousel)
        .navigationTitle(backyard.name)
    }
}
