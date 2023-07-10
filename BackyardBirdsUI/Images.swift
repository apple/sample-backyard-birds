/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A convenience extension to `ImageResource`.
*/

import SwiftUI

public extension ImageResource {
    static let fountainImage = ImageResource(name: "fountain", bundle: .module)
    static let fountainFillImage = ImageResource(name: "fountain.fill", bundle: .module)
}
