/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The shop view modifier.
*/

import SwiftUI
import SwiftData
import BackyardBirdsData
import OSLog

private let logger = Logger(subsystem: "BackyardBirds", category: "BackyardBirdsShopViewModifier")

struct BackyardBirdsShopViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .subscriptionPassStatusTask()
        .onAppear {
            logger.info("Creating BirdBrain shared instance")
            BirdBrain.createSharedInstance(modelContext: modelContext)
            logger.info("BirdBrain shared instance created")
        }
        .task {
            logger.info("Starting tasks to observe transaction updates")
            // Begin observing StoreKit transaction updates in case a
            // transaction happens on another device.
            await BirdBrain.shared.observeTransactionUpdates()
            // Check if we have any unfinished transactions where we
            // need to grant access to content
            await BirdBrain.shared.checkForUnfinishedTransactions()
            logger.info("Finished checking for unfinished transactions")
        }
    }
}

extension View {
    func backyardBirdsShop() -> some View {
        modifier(BackyardBirdsShopViewModifier())
    }
}
