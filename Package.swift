// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "UIImageColors",
    products: [
        .library(name: "UIImageColors", targets: ["UIImageColors"])
    ],
    targets: [
        .target(name: "UIImageColors", path: "UIImageColors")
    ]
)
