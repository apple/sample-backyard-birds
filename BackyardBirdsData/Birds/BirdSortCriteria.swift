/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird sorting criteria.
*/

import Foundation

public enum BirdSortCriteria {
    case recentlyVisited
    case favoriteFood
    case dislikedFoods
    case favorites
    case species
}

public extension BirdSortCriteria {
    var title: String {
        switch self {
        case .recentlyVisited:
            String(
                localized: "Recently Visited",
                table: "Birds",
                bundle: .module,
                comment: "A short phrase that describes a sort criteria based on how recently a bird has visited."
            )
        case .favoriteFood:
            String(
                localized: "Favorite Food",
                table: "Birds",
                bundle: .module,
                comment: "A short phrase that describes a sort criteria based on birds' favorite foods."
            )
        case .dislikedFoods:
            String(
                localized: "Disliked Foods",
                table: "Birds",
                bundle: .module,
                comment: "A short phrase that describes a sort criteria based on birds' disliked foods."
            )
        case .favorites:
            String(
                localized: "Favorite Birds",
                table: "Birds",
                bundle: .module,
                comment: "A short phrase that describes a sort criteria for the user's favorite birds."
            )
        case .species:
            String(
                localized: "Species",
                table: "Birds",
                bundle: .module,
                comment: "A short phrase that describes a sort criteria based on the bird species."
            )
        }
    }
}
