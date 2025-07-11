// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Keystone",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "Keystone", targets: ["Keystone"])
    ],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .target(
            name: "Keystone",
            dependencies: ["Cadova"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
        .executableTarget(
            name: "Example",
            dependencies: ["Keystone", "Cadova"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        )
    ]
)
