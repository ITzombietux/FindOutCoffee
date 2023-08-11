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
        .library(
            name: "FirebaseDependency",
            targets: ["FirebaseDependency"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "main"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "9.0.0")
    ],
    targets: [
        .target(
            name: "UserDefaults",
            dependencies: []
        ),
        .target(
            name: "LoginFeature",
            dependencies: [
                "FirebaseDependency",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "ReviewFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "FirebaseDependency",
            dependencies: [
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestoreSwift", package: "firebase-ios-sdk"),
            ]
        ),
        .testTarget(
            name: "FindOutCoffeePackageTests",
            dependencies: []
        ),
    ]
)
