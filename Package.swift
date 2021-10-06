// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "UIImageColors",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "UIImageColors",
            targets: ["UIImageColors"])
    ],
    targets: [
        .target(
            name: "UIImageColors",
            path: "UIImageColors")
    ]
)
