/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The fountain.
*/

import SwiftUI
import BackyardBirdsData

private let variants = [
    "Terracotta", "Stone", "Marble"
]

public struct FountainArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    
    var variant: String {
        variants[variantIndex]
    }
    
    public var body: some View {
        Image("Fountain/\(variant)", bundle: .module)
            .resizable()
            .scaledToFit()
    }
}
