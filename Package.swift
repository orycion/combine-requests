// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CombineRequests",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "CombineRequests",
            targets: ["CombineRequests"]
        ),
    ],
    targets: [
        .target(
            name: "CombineRequests",
            dependencies: []
        ),
        .testTarget(
            name: "CombineRequestsTests",
            dependencies: ["CombineRequests"]
        ),
    ]
)
