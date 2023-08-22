/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard data.
*/

import Foundation
import Observation
import SwiftData

@Model public class Backyard {
    @Attribute(.unique) public var id: String
    public var name: String
    public var waterRefillDate: Date
    public var foodRefillDate: Date
    public var creationDate: Date
    public var presentingVisitor: Bool
    public var isFavorite: Bool
    public var timeIntervalOffset: TimeInterval
    public var birdFood: BirdFood?
    public var visitorEvents: [BackyardVisitorEvent] = []
    
    @Relationship(inverse: \Plant.backyard)
    public var leadingPlants: [Plant] = []
    
    @Relationship(inverse: \Plant.backyard)
    public var trailingPlants: [Plant] = []
    
    public var floorVariant: Int
    public var fountainVariant: Int
    public var leadingSilhouetteVariant: Int
    public var trailingSilhouetteVariant: Int
    public var leadingForegroundPlantVariant: Int
    public var trailingForegroundPlantVariant: Int
    
    public var currentVisitorEvent: BackyardVisitorEvent? {
        guard let event = visitorEvents.first(where: { $0.dateRange.contains(.now) }) else {
            return nil
        }
        return event
    }
    
    public var hasVisitor: Bool {
        currentVisitorEvent != nil
    }
    
    public var needsToPresentVisitor: Bool {
        hasVisitor && !presentingVisitor
    }
    
    public var historicalEvents: [BackyardVisitorEvent] {
        visitorEvents
            .filter { $0.endDate < .now }
            .sorted(using: KeyPathComparator(\.endDate, order: .reverse))
    }
    
    public var colorData: BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData.colorData(timeInterval: timeIntervalOffset - creationDate.timeIntervalSinceNow)
    }
    
    public init(name: String?) {
        self.id = UUID().uuidString
        self.name = name ?? String(localized: "Backyard", table: "Backyards", bundle: .module)
        self.creationDate = .now
        self.waterRefillDate = .now
        self.foodRefillDate = .now
        self.presentingVisitor = false
        self.isFavorite = false
        self.timeIntervalOffset = TimeInterval(hours: 12)
        self.floorVariant = 0
        self.fountainVariant = 0
        self.leadingSilhouetteVariant = 0
        self.trailingSilhouetteVariant = 0
        self.leadingForegroundPlantVariant = 0
        self.trailingForegroundPlantVariant = 0
    }
    
    public func expectedEmptyDate(for supplies: BackyardSupplies) -> Date {
        refillDate(for: supplies).addingTimeInterval(supplies.totalDuration)
    }
    
    public func lowSuppliesDate(for supplies: BackyardSupplies) -> Date {
        refillDate(for: supplies).addingTimeInterval(supplies.durationUntilLow)
    }
    
    public func refillDate(for supplies: BackyardSupplies) -> Date {
        switch supplies {
        case .food:
            foodRefillDate
        case .water:
            waterRefillDate
        }
    }
    
    public func refillSupplies() {
        refillSupplies(.food)
        refillSupplies(.water)
    }
    
    public func refillSupplies(_ supplies: BackyardSupplies) {
        switch supplies {
        case .food:
            foodRefillDate = .now
        case .water:
            waterRefillDate = .now
        }
    }
}

// MARK: - Backyard Snapshots

extension Backyard {
    public func snapshots(through date: Date, total: Int = 12) -> [BackyardSnapshot] {
        var unmergedSnapshots: [BackyardSnapshot] = []
        
        // Upcoming visitor events.
        let relevantVisitorEvents = visitorEvents.filter { event in
            event.startDate > .now && event.endDate < date
        }
        
        // Add both arrival and departure snapshots.
        for event in relevantVisitorEvents {
            let arriveSnapshot = BackyardSnapshot(
                backyard: self,
                visitingBird: event.bird,
                visitingBirdDuration: event.duration,
                timeInterval: timeIntervalOffset + event.startDate.timeIntervalSinceNow,
                date: event.startDate,
                notableEvents: [.visitorArrive]
            )
            unmergedSnapshots.append(arriveSnapshot)
            let departSnapshot = BackyardSnapshot(
                backyard: self,
                visitingBird: nil,
                timeInterval: timeIntervalOffset + event.endDate.timeIntervalSinceNow,
                date: event.endDate,
                notableEvents: [.visitorDepart]
            )
            unmergedSnapshots.append(departSnapshot)
        }
        
        // Add general time of day transitions.
        for timeInterval in stride(from: 0, through: date.timeIntervalSinceNow, by: TimeInterval(hours: 1)) {
            let timeInterval = timeIntervalOffset + timeInterval
            
            // Near 12 a.m., 6 a.m., 12 p.m., 6 p.m.
            let isSignificantTime = timeInterval.truncatingRemainder(dividingBy: TimeInterval(hours: 6)) <= TimeInterval(hours: 1)
            
            unmergedSnapshots.append(BackyardSnapshot(
                backyard: self,
                visitingBird: nil,
                timeInterval: timeInterval,
                date: Date(timeIntervalSinceNow: timeInterval),
                notableEvents: isSignificantTime ? [.signifantTimeOfDay] : []
            ))
        }
        
        // Add snapshots for low supplies.
        for date in [lowSuppliesDate(for: .food), lowSuppliesDate(for: .food)] {
            unmergedSnapshots.append(BackyardSnapshot(
                backyard: self,
                visitingBird: nil,
                timeInterval: timeIntervalOffset + date.timeIntervalSinceNow,
                date: date,
                notableEvents: [.lowSupplySeverityIncrease]
            ))
        }
        
        // Sort by date and merge any nearby events.
        
        unmergedSnapshots.sort(using: KeyPathComparator(\.date))
        var snapshots: [BackyardSnapshot] = [unmergedSnapshots.first!]
        
        for next in unmergedSnapshots.dropFirst() {
            if let merged = snapshots.last!.merged(with: next) {
                snapshots[snapshots.count - 1] = merged
            } else {
                snapshots.append(next)
            }
        }
        
        snapshots = snapshots
            .sorted(using: KeyPathComparator(\.priority, order: .reverse))
            .prefix(total - 1)
            .sorted(using: KeyPathComparator(\.date))
            
        // Initial state.
        snapshots.insert(BackyardSnapshot(
            backyard: self,
            visitingBird: currentVisitorEvent?.bird,
            timeInterval: timeIntervalOffset,
            date: .now
        ), at: 0)
        
        return snapshots
    }
}
