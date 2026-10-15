// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "Keystone",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "Keystone", targets: ["Keystone"])
    ],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", branch: "dev"),
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
