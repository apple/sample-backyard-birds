/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The resupply backyard intent.
*/

import AppIntents
import SwiftData
import BackyardBirdsData

struct ResupplyBackyardIntent: AppIntent {
    static var title: LocalizedStringResource = "Refill Backyard Supplies"
    
    @Parameter(title: "Backyard")
    var backyard: BackyardEntity
    
    init(backyard: BackyardEntity) {
        self.backyard = backyard
    }
    
    init() {
    }
    
    func perform() async throws -> some IntentResult {
        let modelContext = ModelContext(DataGeneration.container)
        let id = backyard.id
        guard let backyard = try! modelContext.fetch(
            FetchDescriptor<Backyard>(predicate: #Predicate { $0.id == id })
        ).first else {
            return .result()
        }
        backyard.refillSupplies()
        try! modelContext.save()
        return .result()
    }
}
