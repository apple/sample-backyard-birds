// swift-tools-version: 5.9

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The package that defines the app's data.
*/

import PackageDescription

let package = Package(
    name: "BackyardBirdsData",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "BackyardBirdsData",
            type: .dynamic,
            targets: ["BackyardBirdsData"]
        )
    ],
    targets: [
        .target(
            name: "BackyardBirdsData",
            path: "."
        )
    ]
)
