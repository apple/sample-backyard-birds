/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Search suggestions.
*/

import SwiftUI
import BackyardBirdsData

struct BackyardSearchSuggestion: Hashable, Identifiable {
    enum VisitorStatus: Hashable {
        case current(Bird, Backyard)
        case previous(Bird, [Backyard])
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .current(let bird, let backyard):
                hasher.combine(0)
                hasher.combine(bird)
                hasher.combine(backyard)
            case .previous(let bird, let backyards):
                hasher.combine(1)
                hasher.combine(bird)
                hasher.combine(backyards)
            }
        }
    }
    
    var id: Bird.ID { bird.id }
    var bird: Bird
    var backyards: [Backyard]
    var visitorStatus: VisitorStatus?
    
    init?(visitor: BackyardVisitorEvent, backyards: [Backyard]) {
        guard let backyard = backyards.first else { return nil }
        guard let bird = visitor.bird else { return nil }
        
        self.bird = bird
        self.backyards = backyards
        if visitor.endDate < .now {
            visitorStatus = .previous(bird, backyards)
        } else {
            visitorStatus = .current(bird, backyard)
        }
    }
}
