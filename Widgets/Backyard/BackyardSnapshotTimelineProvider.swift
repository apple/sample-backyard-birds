/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The widget's timeline provider.
*/

import BackyardBirdsData
import SwiftData
import WidgetKit
import OSLog

private let logger = Logger(subsystem: "Widgets", category: "BackyardSnapshotTimelineProvider")

struct BackyardWidgetEntry: TimelineEntry {
    var date: Date
    var snapshot: BackyardSnapshot?
    
    static var empty: Self {
        Self(date: .now)
    }
}

struct BackyardSnapshotTimelineProvider: AppIntentTimelineProvider {
    let modelContext = ModelContext(DataGeneration.container)
    
    init() {
        DataGeneration.generateAllData(modelContext: modelContext)
    }
    
    func backyards(for configuration: BackyardWidgetIntent) -> [Backyard] {
        if let id = configuration.specificBackyard?.id {
            try! modelContext.fetch(
                FetchDescriptor<Backyard>(predicate: #Predicate { $0.id == id })
            )
        } else if configuration.backyards == .favorites {
            try! modelContext.fetch(
                FetchDescriptor<Backyard>(predicate: #Predicate { $0.isFavorite == true })
            )
        } else {
            try! modelContext.fetch(FetchDescriptor<Backyard>())
        }
    }
    
    func placeholder(in context: Context) -> BackyardWidgetEntry {
        let backyard = try! modelContext.fetch(FetchDescriptor<Backyard>(sortBy: [.init(\.creationDate)])).first!
        return BackyardWidgetEntry(
            date: .now,
            snapshot: BackyardSnapshot(
                backyard: backyard,
                visitingBird: nil,
                timeInterval: backyard.timeIntervalOffset,
                date: .now,
                notableEvents: []
            )
        )
    }

    func snapshot(for configuration: BackyardWidgetIntent, in context: Context) async -> BackyardWidgetEntry {
        logger.info("Finding backyards for widget snapshot, intent: \(String(configuration.backyards.rawValue))")
        let backyards = backyards(for: configuration)
        logger.info("Found \(backyards.count) backyards")
        guard let backyard = backyards.first else {
            return .empty
        }
        
        let snapshot = backyard.snapshots(through: .now, total: 1).first!
        return BackyardWidgetEntry(date: snapshot.date, snapshot: snapshot)
    }
    
    func timeline(for configuration: BackyardWidgetIntent, in context: Context) async -> Timeline<BackyardWidgetEntry> {
        logger.info("Finding backyards for widget timeline, intent: \(String(configuration.backyards.rawValue))")
        let backyards = backyards(for: configuration)
        logger.info("Found \(backyards.count) backyards")
        guard let backyard = backyards.first else {
            return Timeline(
                entries: [.empty],
                policy: .never
            )
        }
        
        let snapshots = backyard.snapshots(through: .init(timeIntervalSinceNow: 60 * 60 * 36)).map {
            BackyardWidgetEntry(date: $0.date, snapshot: $0)
        }
        return Timeline(entries: snapshots, policy: .atEnd)
    }
    
    func recommendations() -> [AppIntentRecommendation<BackyardWidgetIntent>] {
        [
            AppIntentRecommendation(intent: BackyardWidgetIntent(backyards: .all), description: "All Backyards"),
            AppIntentRecommendation(intent: BackyardWidgetIntent(backyards: .favorites), description: "Favorite Backyards")
        ]
    }
}
