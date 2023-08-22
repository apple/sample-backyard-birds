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
            if let species = plant.species {
                ForEach(species.parts) { part in
                    if let imageName = imageName(for: part) {
                        Image(imageName, bundle: .module)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "questionmark")
                    }
                }
            }
        }
    }
    
    func imageName(for part: PlantPart) -> String? {
        guard let species = plant.species else { return nil }
        
        var result = "\(species.id)/\(part.name)"
        if part.variants != nil {
            result.append(" \(plant.variant + 1)")
        }
        return result
    }
}

