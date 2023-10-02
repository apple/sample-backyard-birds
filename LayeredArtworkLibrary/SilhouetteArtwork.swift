/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The silhouette.
*/

import SwiftUI

private let variants = [
    ImageResource.building1, .building2, .building3, .building4, .building5,
    .trees1, .trees2, .trees3, .trees4, .trees5
]

public struct SilhouetteArtwork: View {
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

