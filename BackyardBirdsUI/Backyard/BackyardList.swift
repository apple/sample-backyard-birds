/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard list.
*/

import SwiftUI
import SwiftData
import StoreKit
import BackyardBirdsData

public struct BackyardList: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    @Environment(\.passIDs.group) private var passGroupID
    let isSubscribed: Bool
    let onOfferSelection: () -> Void
    let backyardLimit: Int
    
    @State private var offerWasDismissed = false
    @State private var showingNewBackyardForm = false
    
    public init(isSubscribed: Bool, backyardLimit: Int?, onOfferSelection: @escaping () -> Void) {
        self.isSubscribed = isSubscribed
        self.backyardLimit = backyardLimit ?? .max
        self.onOfferSelection = onOfferSelection
    }
    
    private var shouldShowOfferCard: Bool {
        !isSubscribed && !offerWasDismissed
    }
    
    public var body: some View {
        List {
            if shouldShowOfferCard {
                Button {
                    onOfferSelection()
                } label: {
                    BackyardBirdsPassOfferCard()
                }
                .swipeActions {
                    Button(action: {
                        offerWasDismissed = true
                    }, label: {
                        Label("Dismiss", systemImage: "xmark")
                    })
                }
                .animation(.easeInOut, value: offerWasDismissed)
            }
            ForEach(backyards) { backyard in
                NavigationLink(value: backyard.id) {
                    BackyardViewport(backyard: backyard)
                        .overlay(alignment: .topLeading) {
                            Text(backyard.name)
                                .font(.callout)
                                .scenePadding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundStyle(Color.primary.shadow(.drop(color: .black.opacity(0.25), radius: 4, y: 1)))
                        }
                }
                .buttonStyle(.borderless)
                .listRowInsets(EdgeInsets())
                .containerShape(.rect(cornerRadius: 10))
            }
        }
        #if os(watchOS)
        .listStyle(.carousel)
        #endif
    }
}
