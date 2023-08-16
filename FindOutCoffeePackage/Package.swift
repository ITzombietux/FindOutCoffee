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
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.0.0"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", exact: "2.16.0")
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
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "KakaoSDKUser", package: "kakao-ios-sdk")
            ]
        ),
        .target(
            name: "ReviewFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "KakaoLoginDependency",
            dependencies: [
                .product(name: "KakaoSDKCommon", package: "kakao-ios-sdk")
            ]
        ),
        .testTarget(
            name: "FindOutCoffeePackageTests",
            dependencies: []
        ),
    ]
)
