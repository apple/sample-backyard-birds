/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird visit status.
*/

import Foundation

public enum BirdVisitStatus {
    case never
    case recently(Date)
}

// MARK: - Localized Title

public extension BirdVisitStatus {
    var title: String {
        switch self {
        case .never:
            return String(
                localized: "Not yet seen",
                table: "Birds",
                bundle: .module,
                comment: "A phrase used to indicate that a bird has never visited a backyard."
            )
        case .recently(let date):
            return String(
                localized: "Seen \(date.formatted(.relative(presentation: .numeric, unitsStyle: .narrow)))",
                table: "Birds",
                bundle: .module,
                comment: "The variable is a shorthand formatted duration. For example, 4d, 30m, or 20s ago."
            )
        }
    }
}
