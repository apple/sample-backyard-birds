/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Colors that correspond to the time of day in the backyard.
*/

import Foundation
import SwiftUI

public struct BackyardTimeOfDayColorData {
    public var skyGradientStart: ColorData
    public var skyGradientEnd: ColorData
    public var silhouette: ColorData
    public var atmosphereTint: ColorData
    
    public var skyGradientFlat: ColorData {
        skyGradientStart.interpolate(to: skyGradientEnd, percent: 0.5)
    }
    
    public func interpolate(to other: BackyardTimeOfDayColorData, percent: Double, clamped: Bool = true) -> BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData(
            skyGradientStart: skyGradientStart.interpolate(to: other.skyGradientStart, percent: percent, clamped: clamped),
            skyGradientEnd: skyGradientEnd.interpolate(to: other.skyGradientEnd, percent: percent, clamped: clamped),
            silhouette: silhouette.interpolate(to: other.silhouette, percent: percent, clamped: clamped),
            atmosphereTint: atmosphereTint.interpolate(to: other.atmosphereTint, percent: percent, clamped: clamped)
        )
    }
    
    public static func colorData(timeInterval: TimeInterval) -> BackyardTimeOfDayColorData {
        let timeInterval = timeInterval.truncatingRemainder(dividingBy: TimeInterval(days: 1))
        let currentTimeOfDay = BackyardTimeOfDay(timeInterval: timeInterval)
        let nextTimeOfDay = BackyardTimeOfDay(afterTimeInterval: timeInterval)
        let percent = timeInterval.truncatingRemainder(dividingBy: TimeInterval(hours: 1)) / TimeInterval(hours: 1)
        
        return currentTimeOfDay.colorData
            .interpolate(to: nextTimeOfDay.colorData, percent: percent)
    }
}
