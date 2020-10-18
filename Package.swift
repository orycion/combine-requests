// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CombineRequests",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
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
