/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A entities and extensions to define the style.
*/

import SwiftUI

// MARK: - Colors

public struct Colors {
    public static let premiumBirdFoodColor = Color("Premium Bird Food", bundle: .module)
}

public extension ShapeStyle where Self == Color {
    static var premiumBirdFoodColor: Color { Colors.premiumBirdFoodColor }
}

// MARK: - Styles

public struct VibrantShapeStyle: ShapeStyle {
    var opacity: Double
    
    public init(opacity: Double) {
        self.opacity = opacity
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        let startingStyle = {
            switch environment.colorScheme {
            case .light: return Color.black
            case .dark: return Color.white
            @unknown default: return Color.black
            }
        }()
        return startingStyle.opacity(opacity).vibrantlyBlended
    }
}

public extension ShapeStyle where Self == VibrantShapeStyle {
    static func vibrant(opacity: Double) -> Self {
        .init(opacity: opacity)
    }
}

// MARK: - Style Modifiers

public struct VibrantlyBlendedShapeStyle: ShapeStyle {
    var base: AnyShapeStyle
    
    public init(base: AnyShapeStyle) {
        self.base = base
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        switch environment.colorScheme {
        case .light:
            return base.blendMode(.plusDarker)
        case .dark:
            return base.blendMode(.plusLighter)
        @unknown default:
            fatalError()
        }
    }
}

public extension ShapeStyle {
    var vibrantlyBlended: VibrantlyBlendedShapeStyle {
        .init(base: AnyShapeStyle(self))
    }
}
