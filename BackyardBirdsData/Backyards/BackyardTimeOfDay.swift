/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard time of day.
*/

import Foundation
import SwiftUI

public enum BackyardTimeOfDay: Hashable, Codable {
    case night, sunrise, morning, afternoon, sunset
    
    public init(timeInterval: TimeInterval) {
        let timeInterval = timeInterval.truncatingRemainder(dividingBy: TimeInterval(days: 1))
        let hour = Int(floor(timeInterval / TimeInterval(hours: 1)))
        self.init(hour: hour)
    }
    
    public init(afterTimeInterval timeInterval: TimeInterval) {
        let timeInterval = timeInterval.truncatingRemainder(dividingBy: TimeInterval(days: 1))
        let hour = Int(floor(timeInterval / TimeInterval(hours: 1)))
        self.init(hour: hour + 1)
    }
    
    public init(hour: Int) {
        switch hour {
        case 0 ..< 6:
            self = .night
        case 6:
            self = .sunrise
        case 7 ..< 12:
            self = .morning
        case 12 ..< 20:
            self = .afternoon
        case 20:
            self = .sunset
        default:
            self = .night
        }
    }
    
    @ViewBuilder
    public var view: some View {
        Group {
            switch self {
            case .night:
                Image(systemName: "moon")
            case .sunrise:
                Image(systemName: "sunrise")
            case .morning:
                Image(systemName: "sun.min")
            case .afternoon:
                Image(systemName: "sun.max")
            case .sunset:
                Image(systemName: "sunset")
            }
        }
        .id(self)
    }
    
    public var colorSchemeOverride: ColorScheme? {
        if case .night = self {
            return .dark
        }
        return nil
    }
    
    public var colorData: BackyardTimeOfDayColorData {
        switch self {
        case .night: Self.nightColorData
        case .sunrise: Self.sunriseColorData
        case .morning: Self.morningColorData
        case .afternoon: Self.afternoonColorData
        case .sunset: Self.sunsetColorData
        }
    }
}

extension BackyardTimeOfDay {
    static let nightColorData = BackyardTimeOfDayColorData(
        skyGradientStart: ColorData(hue: 231 / 360, saturation: 0.57, brightness: 0.85),
        skyGradientEnd: ColorData(hue: 245 / 360, saturation: 0.41, brightness: 1),
        silhouette: ColorData(hue: 243 / 360, saturation: 0.45, brightness: 0.90),
        atmosphereTint: ColorData(hue: 245 / 360, saturation: 0.22, brightness: 1)
    )
    
    static let sunriseColorData = BackyardTimeOfDayColorData(
        skyGradientStart: ColorData(hue: 31 / 360, saturation: 0.4, brightness: 0.99),
        skyGradientEnd: ColorData(hue: 48 / 360, saturation: 0.31, brightness: 1),
        silhouette: ColorData(hue: 31 / 360, saturation: 0.32, brightness: 0.94),
        atmosphereTint: ColorData(hue: 31 / 360, saturation: 0.15, brightness: 1)
    )
    
    static let morningColorData = BackyardTimeOfDayColorData(
        skyGradientStart: ColorData(hue: 185 / 360, saturation: 0.39, brightness: 0.95),
        skyGradientEnd: ColorData(hue: 186 / 360, saturation: 0.37, brightness: 0.9),
        silhouette: ColorData(hue: 185 / 360, saturation: 0.44, brightness: 0.85),
        atmosphereTint: .white
    )
    
    static let afternoonColorData = BackyardTimeOfDayColorData(
        skyGradientStart: ColorData(hue: 216 / 360, saturation: 0.62, brightness: 1),
        skyGradientEnd: ColorData(hue: 205 / 360, saturation: 0.32, brightness: 1),
        silhouette: ColorData(hue: 216 / 360, saturation: 0.60, brightness: 1),
        atmosphereTint: .white
    )
    
    static let sunsetColorData = BackyardTimeOfDayColorData(
        skyGradientStart: ColorData(hue: 286 / 360, saturation: 0.28, brightness: 1),
        skyGradientEnd: ColorData(hue: 360 / 360, saturation: 0.42, brightness: 1),
        silhouette: ColorData(hue: 322 / 360, saturation: 0.34, brightness: 0.95),
        atmosphereTint: ColorData(hue: 288 / 360, saturation: 0.13, brightness: 1)
    )

}

// MARK: - Localized Title

public extension BackyardTimeOfDay {
    var title: String {
        switch self {
        case .sunrise: String(
            localized: "Sunrise",
            table: "Backyards",
            bundle: .module,
            comment: "Short phrase that describes the sunrise time of day for a backyard."
        )
        case .morning: String(
            localized: "Morning",
            table: "Backyards",
            bundle: .module,
            comment: "Short phrase that describes the morning time of day for a backyard."
        )
        case .afternoon: String(
            localized: "Afternoon",
            table: "Backyards",
            bundle: .module,
            comment: "Short phrase that describes the afternoon time of day for a backyard."
        )
        case .sunset: String(
            localized: "Sunset",
            table: "Backyards",
            bundle: .module,
            comment: "Short phrase that describes the sunset time of day for a backyard."
        )
        case .night: String(
            localized: "Night",
            table: "Backyards",
            bundle: .module,
            comment: "Short phrase that describes the night time of day for a backyard."
        )
        }
    }
}
