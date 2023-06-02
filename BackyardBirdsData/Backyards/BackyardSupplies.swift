/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard supplies.
*/

import Foundation

private let timeIntervalUntilFoodLow = TimeInterval(hours: 8)
private let timeIntervalUntilFoodEmpty = timeIntervalUntilFoodLow + TimeInterval(hours: 1)
private let timeIntervalUntilWaterLow = TimeInterval(hours: 15)
private let timeIntervalUntilWaterEmpty = timeIntervalUntilWaterLow + TimeInterval(hours: 1)

public enum BackyardSupplies: Hashable, CaseIterable, Codable {
    case food
    case water
    
    public var title: String {
        switch self {
        case .food:
            String(localized: "Food")
        case .water:
            String(localized: "Water")
        }
    }
    
    /// The approximate number of seconds after being refilled until this supply is considered "low".
    public var durationUntilLow: TimeInterval {
        switch self {
        case .food:
            timeIntervalUntilFoodLow
        case .water:
            timeIntervalUntilWaterLow
        }
    }
    
    /// The approximate number of seconds after being refilled until this supply is empty.
    public var totalDuration: TimeInterval {
        switch self {
        case .food:
            timeIntervalUntilFoodEmpty
        case .water:
            timeIntervalUntilWaterEmpty
        }
    }
}
