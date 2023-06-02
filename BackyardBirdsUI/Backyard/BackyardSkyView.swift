/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The sky view.
*/

import SwiftUI
import BackyardBirdsData

public struct BackyardSkyView: View {
    var timeInterval: TimeInterval
    
    public init(timeInterval: TimeInterval = 60 * 60 * 12) {
        self.timeInterval = timeInterval
    }
        
    var colorData: BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData.colorData(timeInterval: timeInterval)
    }
        
    public var body: some View {
        LinearGradient(
            colors: [
                colorData.skyGradientStart.color,
                colorData.skyGradientEnd.color
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
