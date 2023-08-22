/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The vibrant bird.
*/

import SwiftUI
import BackyardBirdsData

public struct VibrantBird: View {
    var bird: Bird
    var direction: HorizontalEdge
    
    public init(bird: Bird, direction: HorizontalEdge = .trailing) {
        self.bird = bird
        self.direction = direction
    }
    
    public var body: some View {
        if let species = bird.species {
            Image("Vibrant \(species.id)", bundle: .module)
                .resizable()
                .scaledToFit()
                .scaleEffect(direction == .leading ? -1 : 1)
                .flipsForRightToLeftLayoutDirection(true)
        } else {
            Image(systemName: "questionmark")
        }
    }
}
