// swift-tools-version: 5.9

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The package that defines the app's user interface elements.
*/

import PackageDescription

let package = Package(
    name: "BackyardBirdsUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "BackyardBirdsUI",
            type: .dynamic,
            targets: ["BackyardBirdsUI"]
        )
    ],
    dependencies: [
        .package(path: "../BackyardBirdsData"),
        .package(path: "../LayeredArtworkLibrary")
    ],
    targets: [
        .target(
            name: "BackyardBirdsUI",
            dependencies: [
                .product(name: "BackyardBirdsData", package: "BackyardBirdsData", condition: nil),
                .product(name: "LayeredArtworkLibrary", package: "LayeredArtworkLibrary", condition: nil)
            ],
            path: "."
        )
    ]
)
