/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The silhouette.
*/

import SwiftUI

private let variants = [
    "Building 1", "Building 2", "Building 3", "Building 4", "Building 5",
    "Trees 1", "Trees 2", "Trees 3", "Trees 4", "Trees 5"
]

public struct SilhouetteArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    
    public var body: some View {
        Image(variants[variantIndex], bundle: .module)
            .resizable()
            .scaledToFit()
    }
}

