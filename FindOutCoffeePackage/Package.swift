// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FindOutCoffeePackage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "UserDefaults",
            targets: ["UserDefaults"]
        ),
        .library(
            name: "LoginFeature",
            targets: ["LoginFeature"]
        ),
        .library(
            name: "ReviewFeature",
            targets: ["ReviewFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "UserDefaults",
            dependencies: []
        ),
        .target(
            name: "LoginFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "ReviewFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "FindOutCoffeePackageTests",
            dependencies: []
        ),
    ]
)
