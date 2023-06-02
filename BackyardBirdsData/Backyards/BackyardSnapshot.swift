/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard snapshot.
*/

import Foundation

public struct BackyardSnapshot {
    public var backyard: Backyard
    public var visitingBird: Bird?
    public var visitingBirdDuration: TimeInterval?
    public var timeInterval: TimeInterval
    public var date: Date
    public var notableEvents: Set<NotableEvent> = []
    
    public var timeOfDay: BackyardTimeOfDay {
        BackyardTimeOfDay(timeInterval: timeInterval)
    }
    
    public var priority: Int {
        notableEvents.map(\.priorityValue).reduce(0, +)
    }
    
    public init(backyard: Backyard, visitingBird: Bird? = nil, visitingBirdDuration: TimeInterval? = nil,
                timeInterval: TimeInterval, date: Date, notableEvents: Set<NotableEvent> = []) {
        self.backyard = backyard
        self.visitingBird = visitingBird
        self.visitingBirdDuration = visitingBirdDuration
        self.timeInterval = timeInterval
        self.date = date
        self.notableEvents = notableEvents
    }
    
    public enum NotableEvent {
        /// Sunsets, sunrise, noon, midnight, and so on.
        case signifantTimeOfDay
        
        /// Low water, low bird food, or potentially out of supplies.
        case lowSupplySeverityIncrease
        
        /// Bird arrives.
        case visitorArrive
        
        /// Bird departs.
        case visitorDepart
        
        public var priorityValue: Int {
            switch self {
            case .signifantTimeOfDay: 1
            case .visitorDepart: 1
            case .visitorArrive: 2
            case .lowSupplySeverityIncrease: 3
            }
        }
    }
    
    public func merged(with other: BackyardSnapshot, maxDistance: TimeInterval = TimeInterval(minutes: 5)) -> BackyardSnapshot? {
        // Only merge if these events are within a certain `TimeInterval` distance.
        guard date.distance(to: other.date) < maxDistance else {
            return nil
        }
        let moreRecent = self.date > other.date ? self : other
        let lessRecent = self.date < other.date ? self : other
        return BackyardSnapshot(
            backyard: backyard,
            visitingBird: moreRecent.visitingBird ?? lessRecent.visitingBird,
            visitingBirdDuration: moreRecent.visitingBirdDuration ?? lessRecent.visitingBirdDuration,
            timeInterval: moreRecent.timeInterval,
            date: moreRecent.date,
            notableEvents: moreRecent.notableEvents.union(lessRecent.notableEvents)
        )
    }
}
