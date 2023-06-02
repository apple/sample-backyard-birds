/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The floor.
*/

import SwiftUI

public struct FloorArtwork: View {
    var variant: Int
    
    public init(variant: Int) {
        self.variant = variant
    }
    
    public var body: some View {
        Image("Floor \(variant + 1)", bundle: .module)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

