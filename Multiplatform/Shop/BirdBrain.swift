/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The in-app purchase business logic.
*/

import StoreKit
import OSLog

import SwiftData
import BackyardBirdsData

/// Business logic for in-app purchase
@ModelActor
actor BirdBrain {
    private let logger = Logger(
        subsystem: "Backyard Birds",
        category: "Bird Brain"
    )
    
    private var updatesTask: Task<Void, Never>?
    
    private(set) static var shared: BirdBrain!
    
    static func createSharedInstance(modelContext: ModelContext) {
        shared = BirdBrain(modelContainer: modelContext.container)
    }
    
    func process(transaction verificationResult: VerificationResult<Transaction>) async {
        do {
            let unsafeTransaction = verificationResult.unsafePayloadValue
            logger.log("""
            Processing transaction ID \(unsafeTransaction.id) for \
            \(unsafeTransaction.productID)
            """)
        }
        
        let transaction: Transaction
        switch verificationResult {
        case .verified(let t):
            logger.debug("""
            Transaction ID \(t.id) for \(t.productID) is verified
            """)
            transaction = t
        case .unverified(let t, let error):
            // Log failure and ignore unverified transactions
            logger.error("""
            Transaction ID \(t.id) for \(t.productID) is unverified: \(error)
            """)
            return
        }

        // We only need to handle consumables here. We will check the
        // subscription status each time before unlocking a premium subscription
        // feature.
        if case .consumable = transaction.productType {
            
            // The safest practice here is to send the transaction to your
            // server to validate the JWS and keep a ledger of the bird food
            // each account is entitled to. Since this is just a demonstration,
            // we are going to rely on StoreKit's automatic validation and
            // use SwiftData to keep a ledger of the bird food.
            
            guard let (birdFood, product) = birdFood(for: transaction.productID) else {
                logger.fault("""
                Attempting to grant access to \(transaction.productID) for \
                transaction ID \(transaction.id) but failed to query for
                corresponding bird food model.
                """)
                return
            }
            
            let delta = product.quantity * transaction.purchasedQuantity
            
            if transaction.revocationDate == nil, transaction.revocationReason == nil {
                // SwiftData crashes when we do this, so we'll save this for later
                //                if birdFood.finishedTransactions.contains(transaction.id) {
                //                    logger.log("""
                //                    Ignoring unrevoked transaction ID \(transaction.id) for \
                //                    \(transaction.productID) because we have already added \
                //                    \(birdFood.id) for the transaction.
                //                    """)
                //                    return
                //                }
                
                // This doesn't appear to actually be updating the model
                birdFood.ownedQuantity += delta
                //                birdFood.finishedTransactions.insert(transaction.id)
                
                logger.log("""
                Added \(delta) \(birdFood.id)(s) from transaction ID \
                \(transaction.id). New total quantity: \(birdFood.ownedQuantity)
                """)
                
                // Finish the transaction after granting the user content
                await transaction.finish()
                
                logger.debug("""
                Finished transaction ID \(transaction.id) for \
                \(transaction.productID)
                """)
            } else {
                birdFood.ownedQuantity -= delta
                
                logger.log("""
                Removed \(delta) \(birdFood.id)(s) because transaction ID \
                \(transaction.id) was revoked due to \
                \(transaction.revocationReason?.localizedDescription ?? "unknown"). \
                New total quantity: \(birdFood.ownedQuantity).
                """)
            }
        } else {
            // We can just finish the transction since we will grant access to
            // the subscription based on the subscription status.
            await transaction.finish()
        }
        
        do {
            try modelContext.save()
        } catch {
            logger.error("Could not save model context: \(error.localizedDescription)")
        }
    }
    
    func status(for statuses: [Product.SubscriptionInfo.Status], ids: PassIdentifiers) -> PassStatus {
        // Since Backyard Birds Pass supports family sharing, there may be
        // multiple statuses for different family members. Find the status
        // with the highest level of service, since this is what the
        // subscriber is entitled to service for.
        let effectiveStatus = statuses.max { lhs, rhs in
            let lhsStatus = PassStatus(
                productID: lhs.transaction.unsafePayloadValue.productID,
                ids: ids
            ) ?? .notSubscribed
            let rhsStatus = PassStatus(
                productID: rhs.transaction.unsafePayloadValue.productID,
                ids: ids
            ) ?? .notSubscribed
            return lhsStatus < rhsStatus
        }
        guard let effectiveStatus else {
            return .notSubscribed
        }
        
        let transaction: Transaction
        switch effectiveStatus.transaction {
        case .verified(let t):
            logger.debug("""
            Transaction ID \(t.id) for \(t.productID) is verified
            """)
            transaction = t
        case .unverified(let t, let error):
            // Log failure and do not give access
            logger.error("""
            Transaction ID \(t.id) for \(t.productID) is unverified: \(error)
            """)
            return .notSubscribed
        }
        
        // To prevent fraud, the best practice is to send this status to your server
        // to validate off device. For demonstration purposes, the app relies on automatic
        // validation from StoreKit because there is no server.
        
        return PassStatus(productID: transaction.productID, ids: ids) ?? .notSubscribed
    }
    
    func checkForUnfinishedTransactions() async {
        logger.debug("Checking for unfinished transactions")
        for await transaction in Transaction.unfinished {
            let unsafeTransaction = transaction.unsafePayloadValue
            logger.log("""
            Processing unfinished transaction ID \(unsafeTransaction.id) for \
            \(unsafeTransaction.productID)
            """)
            Task.detached(priority: .background) {
                await self.process(transaction: transaction)
            }
        }
        logger.debug("Finished checking for unfinished transactions")
    }
    
    func observeTransactionUpdates() {
        self.updatesTask = Task { [weak self] in
            self?.logger.debug("Observing transaction updates")
            for await update in Transaction.updates {
                guard let self else { break }
                await self.process(transaction: update)
            }
        }
    }
    
    private func birdFood(for productID: Product.ID) -> (BirdFood, BirdFood.Product)? {
        try? modelContext.fetch(FetchDescriptor<BirdFood>()).birdFood(for: productID)
    }
    
}

