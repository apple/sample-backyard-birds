/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The floor.
*/

import SwiftUI

private let variants = [
    ImageResource.floor1, .floor2, .floor3, .floor4
]

public struct FloorArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    
    public var body: some View {
        Image(variants[variantIndex])
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

