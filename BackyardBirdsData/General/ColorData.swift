/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The color data.
*/

import SwiftUI

public struct ColorData: Codable {
    public var hue: Double
    public var saturation: Double
    public var brightness: Double
    
    public init(hue: Double, saturation: Double, brightness: Double) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
    
    public var color: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness)
    }
    
    public func darken(_ percent: Double = 0.9) -> ColorData {
        var copy = self
        copy.brightness *= percent
        copy.saturation *= 1 + ((1 - percent) * 0.5)
        return copy
    }
    
    public func interpolate(to other: ColorData, percent: Double, clamped: Bool = true) -> ColorData {
        ColorData(
            hue: Angle.degrees(hue * 360).interpolate(to: Angle.degrees(other.hue * 360), percent: percent).degrees / 360,
            saturation: saturation.interpolate(to: other.saturation, percent: percent, clamped: clamped),
            brightness: brightness.interpolate(to: other.brightness, percent: percent, clamped: clamped)
        )
    }
    
    public static func pastel(hue: Range<Double>, random: inout SeededRandomGenerator) -> ColorData {
        ColorData(hue: .random(in: hue, using: &random), saturation: 0.6, brightness: 1)
    }
    
    public static func pastel(hue: Double) -> ColorData {
        ColorData(hue: hue, saturation: 0.6, brightness: 1)
    }
    
    public static func white(brightness: Double) -> ColorData {
        ColorData(hue: 0, saturation: 0, brightness: brightness)
    }
    
    public static func vibrant(hue: Range<Double>, random: inout SeededRandomGenerator) -> ColorData {
        ColorData(hue: .random(in: hue, using: &random), saturation: 0.6, brightness: 1)
    }
    
    public static var white: ColorData { .init(hue: 0, saturation: 0, brightness: 1) }
}

@propertyWrapper
struct ClampedScalar: Codable {
    var wraps: Bool = false
    var value: Double
    var wrappedValue: Double {
        get { value }
        set {
            var valueToClamp = newValue
            if wraps {
                valueToClamp = valueToClamp.truncatingRemainder(dividingBy: 1)
            }
            value = min(max(valueToClamp, 0), 1)
        }
    }
    
    init(wrappedValue value: Double, wraps: Bool = false) {
        self.value = value
        self.wraps = wraps
    }
}
