/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The view that holds the watch app's visual content.
*/

import SwiftUI
import SwiftData
import StoreKit
import BackyardBirdsData
import BackyardBirdsUI

struct ContentView: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    @Environment(\.passStatus) private var passStatus
    @Environment(\.passStatusIsLoading) private var passStatusIsLoading
    @Environment(\.passIDs.group) private var groupID
    @State private var showingSubscriptionStore = false
    
    private var isSubscribed: Bool {
        return passStatus != .notSubscribed && !passStatusIsLoading
    }
    
    var body: some View {
        NavigationSplitView {
            BackyardList(isSubscribed: isSubscribed, backyardLimit: passStatus.backyardLimit, onOfferSelection: showSubscriptionStore)
            .navigationTitle("Backyard Birds")
            .navigationDestination(for: Backyard.ID.self) { backyardID in
                if let backyard = backyards.first(where: { $0.id == backyardID }) {
                    BackyardTabView(backyard: backyard)
                }
            }
        } detail: {
            ContentUnavailableView("Select a Backyard", systemImage: "bird", description: Text("Pick something from the list."))
        }
        .sheet(isPresented: $showingSubscriptionStore) {
            SubscriptionStoreView(groupID: groupID)
        }
        .onInAppPurchaseCompletion { _, purchaseResult in
            guard case .success(let verificationResult) = purchaseResult,
                  case .success(_) = verificationResult else {
                return
            }
            showingSubscriptionStore = false
        }
    }
    
    private func showSubscriptionStore() {
        showingSubscriptionStore = true
    }
}
