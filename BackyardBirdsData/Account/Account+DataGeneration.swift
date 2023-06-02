/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Generates the account data.
*/

import Foundation
import OSLog
import SwiftData

private let logger = Logger(subsystem: "BackyardBirdsData", category: "Account Generation")

extension Account {
    static func generateAccount(modelContext: ModelContext) {
        logger.info("Generating/Fetching Account")
        let bird = try! modelContext.fetch(FetchDescriptor<Bird>(sortBy: [.init(\.creationDate)])).first!
        
        let date = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 5, hour: 9, minute: 41))!
        let account = Account(
            joinDate: date,
            displayName: "Ravi Patel",
            emailAddress: "ravipatel@icloud.com",
            isPremiumMember: true
        )
        modelContext.insert(account)
        account.bird = bird
        
        logger.info("Finished Generating/Fetching Account")
    }
}
