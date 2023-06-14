/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The bird food.
*/

import Observation
import SwiftUI
import SwiftData
import OSLog

private let logger = Logger(subsystem: "Backyard Birds Data", category: "BirdFood")

@Model public class BirdFood {
    @Attribute(.unique) public var id: String
    public var name: String
    public var summary: String
    public var priority: Int

    /// The corresponding in-app purchase products if this is a premium food item.
    public var products: [Product]
    /// The owned quantity if this is a premium food item.
    public var ownedQuantity: Int
    /// Track the StoreKit transactions that  have finished for this product
    /// to avoid repeatedly granting content for one transaction.
        
    public var isPremium: Bool {
        !products.isEmpty
    }
    
    public var orderedProducts: [Product] {
        products.sorted { lhs, rhs in
            lhs.quantity < rhs.quantity
        }
    }
    
    public init(
        id: String,
        name: String,
        summary: String,
        products: [Product] = [],
        priority: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.products = products
        self.ownedQuantity = 0
        self.priority = priority ?? (products.isEmpty ? 0 : 1)
//        self.finishedTransactions = []
    }
    
    public struct Product: Identifiable, Codable {
        public var id: String
        public var quantity: Int
    }
}

// MARK: - All Bird Food

extension BirdFood {
    public var image: Image {
        Image("Bird Food/\(id)", bundle: .module)
            .resizable()
    }
    
    public var alternateImage: Image {
        Image("Bird Food/Shop Alternates/\(id)", bundle: .module)
            .resizable()
    }
}

extension Sequence where Element == BirdFood {
    
    public func birdFood(for productID: String) -> (BirdFood, BirdFood.Product)? {
        lazy.compactMap { birdFood in
            birdFood.products
                .first { $0.id == productID }
                .map { (birdFood, $0) }
        }
        .first
    }
    
}
