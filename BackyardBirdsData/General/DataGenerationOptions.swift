/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Options for generating the data.
*/

import Foundation

public class DataGenerationOptions {
    /// A Boolean that you set to indicate whether to display a new bird indicator using PhaseAnimator in SwiftUI.
    public static let showNewBirdIndicatorCard = false
    
    /// A Boolean that you set to indicate whether the first backyard is initially low on water.
    public static let firstBackyardLowOnWater = false
    
    /// Logic that determines how to display the first bird in the default backyard.
    public static let firstBackyardBirdStatus = FirstBackyardBirdStatus.alreadyVisible
    
    /// Birds initially default to visiting for an hour after the app launches.
    public static let currentBirdsVisitingDuration = TimeInterval(hours: 1)
    
    /// When true, do not save data to disk. When false, saves data to disk.
    public static let inMemoryPersistence = true
    
    public static let initialOwnedBirdFoods: [String: Int] = [
        "Nutrition Pellet": 3
    ]
}

// MARK: - FirstBackyardBirdStatus

public extension DataGenerationOptions {
    
    enum FirstBackyardBirdStatus {
        /// The bird is shown initially as if it's been there for a while.
        case alreadyVisible
        
        /// The bird is visiting but needs to be drawn flying in.
        case fliesIn
        
        /// No bird is visiting.
        case notVisiting
    }
}
