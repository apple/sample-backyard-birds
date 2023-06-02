/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A seeded random number generator wrapper.
*/

import Foundation

public struct SeededRandomGenerator: RandomNumberGenerator {
    public init(seed: Int) {
        srand48(seed)
    }
    
    public func next() -> UInt64 {
        UInt64(drand48() * 0x1.0p64) ^ UInt64(drand48() * 0x1.0p16)
    }
}
