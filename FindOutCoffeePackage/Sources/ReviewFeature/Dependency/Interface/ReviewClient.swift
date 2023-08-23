//
//  ReviewClient.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct SubmitReviewRequest: Codable, Identifiable {
    public var id = UUID()
    var userIdentifier: String
    var coffee: Coffee
    var selectedTitle: String
}

public struct SubmitImagesRequest: Codable {
    let menuIdentifier: String
    let userIdentifier: String
    let photosData: [Data]
}

public struct Coffee: Codable {
    var nickname: String
    var title: String
    var size: String
    var isHot: String
    var text: String
    var address: String
    var category: String
    var date: String
    var feeling: String
    var isRecommend: Bool
    var isPublic = false
    
    init(nickname: String, title: String, size: String, isHot: String, text: String, address: String, category: String, date: String, feeling: String, isRecommend: Bool) {
        self.nickname = nickname
        self.title = title
        self.size = size
        self.isHot = isHot
        self.text = text
        self.address = address
        self.category = category
        self.date = date
        self.feeling = feeling
        self.isRecommend = isRecommend
    }
}

public struct SubmitReviewResponse: Codable {
    let menuIdentifier: String
    let userIdentifier: String
}

public struct SubmitImagesResponse: Codable {}

public struct CafeNamesResponse {
    var names: [String]
}

public struct CafeCategoresResponse {
    var names: [String]
}

public struct CafeMenusResponse {
    var names: [String]
}

public struct ConvenienceStoreBrandsResponse {
    var names: [String]
}

public struct ConvenienceStoreMenusResponse {
    var names: [String]
}

public struct ReviewClient {
    public var submit: @Sendable (SubmitReviewRequest) async throws -> SubmitReviewResponse
    public var uploadImages: @Sendable (SubmitImagesRequest) async throws -> SubmitImagesResponse
    public var cafeNames: @Sendable () async throws -> CafeNamesResponse
    public var cafeMenus: @Sendable (String, String) async throws -> CafeMenusResponse
    public var cafeCategores: @Sendable (String) async throws -> CafeCategoresResponse
    public var convenienceStoreBrands: @Sendable () async throws -> ConvenienceStoreBrandsResponse
    public var convenienceStoreMenus: @Sendable (String) async throws -> ConvenienceStoreMenusResponse
}

extension ReviewClient: TestDependencyKey {
    public static let testValue = Self(
        submit: unimplemented("\(Self.self).submit"),
        uploadImages: unimplemented("\(Self.self).uploadImages"),
        cafeNames: unimplemented("\(Self.self).cafeNames"),
        cafeMenus: unimplemented("\(Self.self).cafeMenus"),
        cafeCategores: unimplemented("\(Self.self).cafeCategores"),
        convenienceStoreBrands: unimplemented("\(Self.self).convenienceStoreBrands"),
        convenienceStoreMenus: unimplemented("\(Self.self).convenienceStoreMenus")
    )
}

extension DependencyValues {
    var reviewClient: ReviewClient {
        get { self[ReviewClient.self] }
        set { self[ReviewClient.self] = newValue }
    }
}
