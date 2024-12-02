// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Keystone",
    products: [
        .library(name: "Keystone", targets: ["Keystone"])
    ],
    dependencies: [
        .package(url: "https://github.com/tomasf/SwiftSCAD.git", .upToNextMinor(from: "0.9.0")),
    ],
    targets: [
        .target(name: "Keystone", dependencies: ["SwiftSCAD"]),
        .executableTarget(name: "Example", dependencies: ["Keystone", "SwiftSCAD"])
    ]
)
