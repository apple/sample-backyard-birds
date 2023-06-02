/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The entry point for Backyard Birds.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData

@main
struct BackyardBirdsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .backyardBirdsShop()
                .backyardBirdsDataContainer()
        }
    }
}
