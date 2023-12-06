/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The enumeration that defines the Backyard Birds Pass' status.
*/

import StoreKit
import SwiftUI
import SwiftData
import OSLog

import BackyardBirdsData

private let logger = Logger(subsystem: "BackyardBirds", category: "BackyardBirdsPassStatus")

enum PassStatus: Comparable, Hashable {
    case notSubscribed
    case individual
    case family
    case premium
    
    init(levelOfService: Int) {
        self = switch levelOfService {
        case 1: .premium
        case 2: .family
        case 3: .individual
        default: .notSubscribed
        }
    }
    
    init?(productID: Product.ID, ids: PassIdentifiers) {
        switch productID {
        case ids.individual: self = .individual
        case ids.family: self = .family
        case ids.premium: self = .premium
        default: return nil
        }
    }
    
    var backyardLimit: Int? {
        switch self {
        case .notSubscribed: 8
        default: nil
        }
    }
        
}

extension PassStatus: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .notSubscribed: String(localized: "Not Subscribed")
        case .individual: String(localized: "Individual")
        case .family: String(localized: "Family")
        case .premium: String(localized: "Premium")
        }
    }
    
}

extension EnvironmentValues {
    
    private enum PassStatusEnvironmentKey: EnvironmentKey {
        static var defaultValue: PassStatus = .notSubscribed
    }
    
    private enum PassStatusLoadingEnvironmentKey: EnvironmentKey {
        static var defaultValue = true
    }
    
    fileprivate(set) var passStatus: PassStatus {
        get { self[PassStatusEnvironmentKey.self] }
        set { self[PassStatusEnvironmentKey.self] = newValue }
    }
    
    fileprivate(set) var passStatusIsLoading: Bool {
        get { self[PassStatusLoadingEnvironmentKey.self] }
        set { self[PassStatusLoadingEnvironmentKey.self] = newValue }
    }

}

private struct PassStatusTaskModifier: ViewModifier {
    @Environment(\.passIDs) private var passIDs
    @Environment(\.modelContext) private var modelContext

    @State private var state: EntitlementTaskState<PassStatus> = .loading
    
    private var isLoading: Bool {
        if case .loading = state { true } else { false }
    }
    
    func body(content: Content) -> some View {
        content
            .subscriptionStatusTask(for: passIDs.group) { state in
                logger.info("Checking subscription status")
                guard let birdBrain = BirdBrain.shared else { fatalError("BirdBrain was nil.") }
                self.state = await state.map { @Sendable [passIDs] statuses in
                    await birdBrain.status(
                        for: statuses,
                        ids: passIDs
                    )
                }
                // After getting the status, send it to the `DataGeneration`
                // model so the app can generate events with or without early access
                // birds as appropriate.
                switch self.state {
                case .failure(let error):
                    logger.error("Failed to check subscription status: \(error)")
                    DataGeneration.generateVisitorEvents(
                        modelContext: modelContext,
                        includeEarlyAccessSpecies: false
                    )
                case .success(let status):
                    logger.info("Providing updated status to data generation")
                    DataGeneration.generateVisitorEvents(
                        modelContext: modelContext,
                        includeEarlyAccessSpecies: status == .premium
                    )
                case .loading: break
                @unknown default: break
                }
                logger.info("Finished checking subscription status")
            }
            .environment(\.passStatus, state.value ?? .notSubscribed)
            .environment(\.passStatusIsLoading, isLoading)
    }
}

extension View {
    
    func subscriptionPassStatusTask() -> some View {
        modifier(PassStatusTaskModifier())
    }
    
}
