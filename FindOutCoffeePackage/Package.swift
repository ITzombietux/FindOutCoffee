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
            name: "UserDefaultsDependency",
            targets: ["UserDefaultsDependency"]
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
            name: "KakaoLoginDependency",
            targets: ["KakaoLoginDependency"]
        ),
        .library(
            name: "FirebaseDependency",
            targets: ["FirebaseDependency"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.0.0"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", exact: "2.16.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "9.0.0")
    ],
    targets: [
        .target(
            name: "UserDefaultsDependency",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "LoginFeature",
            dependencies: [
                "FirebaseDependency",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "KakaoSDKUser", package: "kakao-ios-sdk")
            ]
        ),
        .target(
            name: "ReviewFeature",
            dependencies: [
                "FirebaseDependency",
                "UserDefaultsDependency",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "KakaoLoginDependency",
            dependencies: [
                .product(name: "KakaoSDKCommon", package: "kakao-ios-sdk")
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
