// swift-tools-version: 5.9

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The package that defines the app's user interface elements.
*/

import PackageDescription

let package = Package(
    name: "LayeredArtworkLibrary",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "LayeredArtworkLibrary",
            type: .dynamic,
            targets: ["LayeredArtworkLibrary"]
        )
    ],
    dependencies: [
        .package(path: "../BackyardBirdsData")
    ],
    targets: [
        .target(
            name: "LayeredArtworkLibrary",
            dependencies: [
                .product(name: "BackyardBirdsData", package: "BackyardBirdsData", condition: nil)
            ],
            path: "."
        )
    ]
)
