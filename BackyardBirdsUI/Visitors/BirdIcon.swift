/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird icon view.
*/

import SwiftUI
import BackyardBirdsData
import LayeredArtworkLibrary

/// A view that displays the bird.
public struct BirdIcon: View {
    /// The bird data.
    var bird: Bird
  
    /// The insets around the bird icon.
    var insets: Double
    
    /// The direction the bird should face.
    ///
    /// Valid values are `.leading` and `.trailing`.
    var direction: HorizontalEdge

    /// Create an instance of `BirdView`.
    /// - Parameters:
    ///   - bird: The bird data.
    ///   - insets: The insets around the bird icon. If `nil`, the system's default insets apply.
    ///   - direction: The direction the bird should face. Valid values are `.leading` and `.trailing`.
    public init(bird: Bird, insets: Double? = nil, direction: HorizontalEdge = .leading) {
        self.bird = bird
        self.insets = insets ?? 6
        self.direction = direction
    }
    
    /// Create the bird icon view.
    ///
    /// The bird icon view is a tailored version of the ``ComposedBird`` view.
    public var body: some View {
        ComposedBird(bird: bird, direction: direction)
            .padding(insets)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                BackyardSkyView(timeInterval: bird.backgroundTimeInterval)
                    .opacity(0.8)
                    .clipShape(.containerRelative)
            }
            .background(.fill.tertiary)
            .overlay {
                ContainerRelativeShape().strokeBorder(.tertiary)
            }
            .containerShape(.circle)
            .compositingGroup()
    }
}

#Preview {
    ModelPreview { bird in
        BirdIcon(bird: bird)
    }
}
