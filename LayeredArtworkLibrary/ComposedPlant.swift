/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The plant, composed of its parts.
*/

import BackyardBirdsData
import SwiftUI

public struct ComposedPlant: View {
    var plant: Plant
    
    public init(plant: Plant) {
        self.plant = plant
    }
    
    public var body: some View {
        ZStack {
            ForEach(plant.species.parts) { part in
                Image(imageName(for: part), bundle: .module)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    func imageName(for part: PlantPart) -> String {
        var result = "\(plant.species.id)/\(part.name)"
        if part.variants != nil {
            result.append(" \(plant.variant + 1)")
        }
        return result
    }
}

