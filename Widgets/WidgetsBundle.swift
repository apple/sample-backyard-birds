/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The widget bundle.
*/

import WidgetKit
import SwiftUI
import SwiftData
import BackyardBirdsData

@main
struct WidgetsBundle: WidgetBundle {
    var body: some Widget {
        BackyardWidget()
    }
}
