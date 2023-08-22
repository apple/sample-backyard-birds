/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The recent visitors view.
*/

import SwiftUI
import BackyardBirdsData
import LayeredArtworkLibrary

public struct RecentBackyardVisitorsView: View {
    var backyard: Backyard
    
    @State private var seeAll = false
    
    public init(backyard: Backyard) {
        self.backyard = backyard
    }
    
    var events: [BackyardVisitorEvent] {
        if !seeAll {
            return Array(backyard.historicalEvents.prefix(6))
        } else {
            return backyard.historicalEvents
        }
    }
    
    public var body: some View {
        ForEach(events) { event in
            HStack {
                if let bird = event.bird {
                    BirdIcon(bird: bird)
                        .frame(width: 60, height: 60)
                }
                
                VStack(alignment: .leading) {
                    Text(event.bird?.speciesName ?? "- The event is missing the bird. -")
                    Text(event.endDate, style: .relative)
                        .foregroundStyle(.secondary)
                        .font(.callout)
                }
                Spacer()
            }
            #if !os(watchOS)
            .padding()
            .background(.fill.tertiary, in: .rect(cornerRadius: 20))
            #endif
        }
        
        Button {
            withAnimation {
                seeAll.toggle()
            }
        } label: {
            if seeAll {
                Text("Show Less", bundle: .module)
            } else {
                Text("Show More", bundle: .module)
            }
        }
        #if !os(watchOS)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        #endif
    }
}

#Preview {
    ModelPreview { backyard in
        RecentBackyardVisitorsView(backyard: backyard)
    }
}

private extension ScrollTransitionPhase {
    var scaleAnchor: UnitPoint {
        switch self {
            case .topLeading: .top
            case .bottomTrailing: .bottom
            default: .center
        }
    }
}
