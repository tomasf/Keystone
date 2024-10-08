// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Keystone",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "Keystone", targets: ["Keystone"])
    ],
    dependencies: [
        .package(url: "https://github.com/tomasf/SwiftSCAD.git", from: "0.7.0"),
    ],
    targets: [
        .target(
            name: "Keystone",
            dependencies: ["SwiftSCAD"],
            swiftSettings: [.enableUpcomingFeature("ExistentialAny")]
        ),
        .executableTarget(name: "Example", dependencies: ["Keystone", "SwiftSCAD"])
    ]
)
