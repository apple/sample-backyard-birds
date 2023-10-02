/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The fountain.
*/

import SwiftUI
import BackyardBirdsData

private let variants = [
    ImageResource.Fountain.terracotta, .Fountain.stone, .Fountain.marble
]

public struct FountainArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    
    public var body: some View {
        Image(variants[variantIndex])
            .resizable()
            .scaledToFit()
    }
}
