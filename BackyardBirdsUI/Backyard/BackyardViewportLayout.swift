/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard viewport's layout.
*/

import SwiftUI

enum BackyardViewportContent: Hashable {
    case silhouette
    case horizon(HorizontalEdge)
    case floor
    case plant(HorizontalEdge)
    case fountain
    case bird
}

struct BackyardViewportContentKey: LayoutValueKey {
    static var defaultValue: BackyardViewportContent = .fountain
}

struct BackyardViewportLayout: Layout {
    var birdNaturalScale: Double = 1
    
    struct LayoutResult {
        var width: Double
        var height: Double {
            if width <= 0 {
                return 0
            } else if width < 150 {
                return 50
            } else if width < 300 {
                return 120
            } else if width < 600 {
                return 180
            } else {
                return 240
            }
        }
        
        var size: CGSize {
            CGSize(width: width, height: height)
        }
        
        var birdAssetSize: Double {
            let desiredSize = height * 0.45
            return min(max(desiredSize, 70), 120)
        }
        
        var fountainAssetSize: Double {
            birdAssetSize * 2
        }
        
        var plantAssetSize: Double {
            birdAssetSize * 1.5
        }
        
        var birdBounds: CGRect {
            let topPadding = birdAssetSize * 0.3
            return CGRect(x: (width * 0.5) - (birdAssetSize * 0.5), y: topPadding, width: birdAssetSize, height: birdAssetSize)
        }
        
        var fountainY: Double {
            birdBounds.maxY + fountainAssetSize * 0.66
        }
        
        var groundPlaneY: Double {
            birdBounds.maxY + fountainAssetSize * 0.45
        }
        
        var horizonY: Double {
            groundPlaneY - (height * 0.4)
        }
        
        var fountainBounds: CGRect {
            CGRect(x: width * 0.5 - (fountainAssetSize * 0.5), y: fountainY - fountainAssetSize, width: fountainAssetSize, height: fountainAssetSize)
        }
        
        func plantBounds(leading: Bool, index: Int, totalCount: Int) -> CGRect {
            guard totalCount > 0 else {
                return .zero
            }
            let sideItemsDistance = fountainAssetSize * 0.5
            let spacing = plantAssetSize * 0.35
            let itemOffset = 0.0
                + sideItemsDistance
                + (Double(index) * spacing)
            let depthY = Double(1 - index) * height * -0.12
            let plantsYOffset = plantAssetSize * -0.06
            let xPos = (width * 0.5) - (plantAssetSize * 0.5) + (itemOffset * (leading ? -1 : 1))
            return CGRect(
                x: xPos,
                y: groundPlaneY - (plantAssetSize * 2) + depthY + plantsYOffset,
                width: plantAssetSize,
                height: plantAssetSize * 2
            )
        }
        
        var silhouetteBounds: CGRect {
            let assetHeight = fountainAssetSize * 0.5
            let minimumWidth = fountainAssetSize * 2
            let assetWidth = max(width, minimumWidth)
            return CGRect(x: (width - assetWidth) * 0.5, y: horizonY - (assetHeight * 0.95), width: assetWidth, height: assetHeight)
        }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let result = LayoutResult(width: proposal.width ?? 0)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let result = LayoutResult(width: proposal.width ?? 0)
        
        var categorizedSubviews: [BackyardViewportContent: [LayoutSubview]] = [:]
        subviews.forEach {
            let content = $0[BackyardViewportContentKey.self]
            categorizedSubviews[content, default: []].append($0)
        }
        
        let silhouetteBounds = result.silhouetteBounds
        for subview in categorizedSubviews[.silhouette, default: []] {
            subview.place(at: bounds.origin + silhouetteBounds.origin, anchor: .topLeading, proposal: ProposedViewSize(silhouetteBounds.size))
        }
        
        for subview in categorizedSubviews[.floor, default: []] {
            subview.place(at: bounds.origin + CGPoint(x: 0, y: result.horizonY), anchor: .topLeading,
                          proposal: ProposedViewSize(width: result.width, height: result.height - result.horizonY))
        }
        
        for (isLeading, sideSubviews) in [(true, categorizedSubviews[.plant(.leading), default: []]),
                                          (false, categorizedSubviews[.plant(.trailing), default: []])] {
            for (index, subview) in zip(sideSubviews.indices, sideSubviews) {
                let subviewBounds = result.plantBounds(leading: isLeading, index: index, totalCount: sideSubviews.count)
                subview.place(at: bounds.origin + subviewBounds.origin, anchor: .topLeading, proposal: ProposedViewSize(subviewBounds.size))
            }
        }
        
        for subview in categorizedSubviews[.fountain, default: []] {
            subview.place(at: bounds.origin + result.fountainBounds.origin, anchor: .topLeading,
                          proposal: ProposedViewSize(result.fountainBounds.size))
        }
        
        var birdBounds = result.birdBounds
        let birdDelta = result.birdBounds.width * (1 - birdNaturalScale)
        birdBounds.origin.x += birdDelta * 0.5
        birdBounds.origin.y += birdDelta * 0.84
        birdBounds.size.width -= birdDelta
        birdBounds.size.height -= birdDelta
        for subview in categorizedSubviews[.bird, default: []] {
            subview.place(at: bounds.origin + birdBounds.origin, anchor: .topLeading, proposal: ProposedViewSize(birdBounds.size))
        }
    }
}
