/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An enum that defines the label of the active screen.
*/

import SwiftUI
import BackyardBirdsUI
import BackyardBirdsData

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case backyards
    case birds
    case plants
    case account
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .backyards:
            Label {
                Text("Backyards")
            } icon: {
                Image.fountain
            }
        case .birds:
            Label("Birds", systemImage: "bird")
        case .plants:
            Label("Plants", systemImage: "leaf")
        case .account:
            Label("Account", systemImage: "person.crop.circle")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .backyards:
            BackyardNavigationStack()
        case .plants:
            PlantsNavigationStack()
        case .birds:
            BirdsNavigationStack()
        case .account:
            AccountNavigationStack()
        }
    }
}
