/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension to TimeInterval.
*/

import Foundation

public extension TimeInterval {
    /// Creates an imaginary time of day for a backyard.
    ///
    /// - Note: This code is solely intended for use with Backyard Birds sample imaginary to simulate a "time of day" for each backyard.
    /// When dealing with real-world time, use `Date` and `Calendar` instead.
    init(days: Double = 0, hours: Double = 0, minutes: Double = 0, seconds: Double = 0) {
        self = (24 * 60 * 60 * days) + (60 * 60 * hours) + (60 * minutes) + seconds
    }
}
