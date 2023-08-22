/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The supply gauge.
*/

import SwiftUI
import BackyardBirdsData

public struct BackyardSupplyGauge: View {
    var backyard: Backyard
    var supplies: BackyardSupplies
    
    @Environment(\.layoutDirection) private var originalLayoutDirection
    
    public init(backyard: Backyard, supplies: BackyardSupplies) {
        self.backyard = backyard
        self.supplies = supplies
    }
    
    public var body: some View {
        Gauge(value: remainingDuration, in: 0...supplies.totalDuration) {
            gaugeLabel
                .environment(\.layoutDirection, originalLayoutDirection)
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(gaugeTint)
        .environment(\.layoutDirection, originalLayoutDirection.opposite)
    }
    
    @ViewBuilder
    var gaugeLabel: some View {
        switch supplies {
        case .food:
            if let birdFood = backyard.birdFood {
                birdFood.image
                    .scaledToFit()
                    .padding(-4)
                    .transition(.scale(scale: 0.5).combined(with: .opacity))
                    .id(birdFood.id)
            } else {
                Image(systemName: "questionmark")
            }
        case .water:
            Image(systemName: "drop.fill")
                .foregroundStyle(.linearGradient(colors: [.mint, .cyan], startPoint: .top, endPoint: .bottom))
                .imageScale(.small)
        }
    }
    
    var gaugeTint: AnyShapeStyle {
        switch supplies {
        case .food:
            AnyShapeStyle(Gradient(colors: [.orange, .pink]))
        case .water:
            AnyShapeStyle(Gradient(colors: [.cyan, .blue]))
        }
    }
    
    var remainingDuration: TimeInterval {
        max(Date.now.distance(to: backyard.expectedEmptyDate(for: supplies)), 0)
    }
}

private extension LayoutDirection {
    var opposite: LayoutDirection {
        self == .leftToRight ? .rightToLeft : .leftToRight
    }
}
