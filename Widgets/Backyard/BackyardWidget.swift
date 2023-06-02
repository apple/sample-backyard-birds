/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard widget.
*/

import WidgetKit
import SwiftUI
import SwiftData
import BackyardBirdsUI
import BackyardBirdsData
import LayeredArtworkLibrary

struct BackyardWidget: Widget {
    private let kind = "Backyard Widget"

    var families: [WidgetFamily] {
        #if os(watchOS)
        return [.accessoryRectangular]
        #elseif os(iOS)
        return [.accessoryRectangular, .systemSmall, .systemMedium, .systemLarge]
        #else
        return [.systemSmall, .systemMedium, .systemLarge]
        #endif
    }
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: BackyardWidgetIntent.self,
            provider: BackyardSnapshotTimelineProvider()
        ) { entry in
            BackyardWidgetView(entry: entry)
        }
        .supportedFamilies(families)
    }
}
