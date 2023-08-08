/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The Backyard Bird Pass store view.
*/

import SwiftUI
import StoreKit
import SwiftData
import BackyardBirdsData
import BackyardBirdsUI
import LayeredArtworkLibrary

// 8:45 p.m. at night uses a great sky gradient.
private let skyTimeInterval = TimeInterval(hours: 20, minutes: 45)

struct BackyardBirdsPassShop: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.passIDs.group) private var passGroupID
    @Environment(\.passStatus) private var passStatus
    
    private var showPremiumUpgrade: Bool {
        passStatus == .individual || passStatus == .family
    }
    
    var body: some View {
        SubscriptionStoreView(
            groupID: passGroupID,
            visibleRelationships: showPremiumUpgrade ? .upgrade : .all
        ) {
            PassMarketingContent(showPremiumUpgrade: showPremiumUpgrade)
                #if !os(watchOS)
                .containerBackground(for: .subscriptionStoreFullHeight) {
                    SkyBackground()
                }
                #endif
        }
        #if os(iOS)
        .storeButton(.visible, for: .redeemCode)
        #else
        .frame(width: 400, height: 550)
        #endif
        .subscriptionStoreControlIcon { _, subscriptionInfo in
            Group {
                switch PassStatus(levelOfService: subscriptionInfo.groupLevel) {
                case .premium:
                    Image(systemName: "bird")
                case .family:
                    Image(systemName: "person.3.sequence")
                default:
                    Image(systemName: "wallet.pass")
                }
            }
            .foregroundStyle(.accent)
            .symbolVariant(.fill)
        }
        #if !os(watchOS)
        .backgroundStyle(.clear)
        .subscriptionStoreButtonLabel(.multiline)
        .subscriptionStorePickerItemBackground(.thinMaterial)
        #endif
    }
    
}

private let tagValue = BirdTag.premiumGoldenHummingbird.rawValue

private struct PassMarketingContent: View {
    var showPremiumUpgrade: Bool = false
    
    @Query(filter: #Predicate<Bird> { $0.tag == tagValue })
    private var birds: [Bird]
    
    init(showPremiumUpgrade: Bool) {
        self.showPremiumUpgrade = showPremiumUpgrade
    }
    
    var body: some View {
        VStack(spacing: 10) {
            #if !os(watchOS)
            if let bird = birds.first {
                ComposedBird(bird: bird, direction: .trailing)
                    .frame(height: 100)
                    .padding(-10)
            }
            #endif
            VStack(spacing: 3) {
                if showPremiumUpgrade {
                    subscriptionName
                    #if !os(watchOS)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .overlay(.bar, in: .capsule.stroke())
                    #endif
                }
                title
                    .font(.largeTitle.bold())
                #if !os(watchOS)
                    .foregroundStyle(.bar)
                #endif
            }
            description
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3.weight(.medium))
                .padding([.bottom, .horizontal])
                .frame(maxWidth: 350)
        }
        .background {
            Capsule()
                .fill(.indigo.opacity(0.5))
                .blur(radius: 60)
        }
        .foregroundStyle(.white)
        .padding(.vertical)
        .padding(.top, 40)
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    private var subscriptionName: some View {
        Text("Backyard Birds Pass")
    }
    
    @ViewBuilder
    private var title: some View {
        if showPremiumUpgrade {
            Text("Premium")
        } else {
            subscriptionName
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if showPremiumUpgrade {
            Text("""
                Early access to new bird species and enhanced journaling for the \
                most avid bird watchers.
                """,
                comment: "Marketing text to advertise Backyard Birds Pass Premium."
            )
        } else {
            Text("""
                More birdhouses and feeders with unlimited backyards for happy \
                habitats
                """,
                comment: "Marketing text to advertise Backyard Birds Pass."
            )
        }
    }
    
}

@available(watchOS, unavailable)
private struct SkyBackground: View {
    var body: some View {
        #if os(watchOS)
        Text("Unsupported")
        #else
        BackyardSkyView(timeInterval: skyTimeInterval)
            .overlay(alignment: .bottom) {
                Ellipse()
                    .fill(.white.opacity(0.2))
                    .frame(width: 800, height: 400)
                    .offset(y: 200)
            }
            .overlay(alignment: .top) {
                Image(.clouds)
                    .resizable()
                    .scaledToFill()
                    .hueRotation(.degrees(70))
                    .frame(height: 200)
            }
        #endif
    }
}

#Preview {
    ZStack {
        BackyardBirdsPassShop()
    }
    .backyardBirdsDataContainer(inMemory: true)
}
