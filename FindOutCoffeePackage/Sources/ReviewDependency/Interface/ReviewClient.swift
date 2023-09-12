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
    public let coffee: Coffee
    public let selectedTitle: String
    
    public init(id: UUID = UUID(), coffee: Coffee, selectedTitle: String) {
        self.id = id
        self.coffee = coffee
        self.selectedTitle = selectedTitle
    }
}

public struct SubmitImagesRequest: Codable {
    public let menuIdentifier: String
    public let userIdentifier: String
    public let selectedTitle: String
    public let photosData: [Data]
    
    public init(menuIdentifier: String, userIdentifier: String, selectedTitle: String, photosData: [Data]) {
        self.menuIdentifier = menuIdentifier
        self.userIdentifier = userIdentifier
        self.selectedTitle = selectedTitle
        self.photosData = photosData
    }
}

public struct Coffee: Codable {
    public let userIdentifier: String
    public let nickname: String
    public let title: String
    public let text: String
    public let address: String
    public let category: String
    public let date: String
    public let feeling: String
    public let isRecommend: Bool
    public let isPublic: Bool
    public let countOfLike: Int
    public let peopleWhoLiked: [String]
    
    public init(userIdentifier: String, nickname: String, title: String, text: String, address: String, category: String, date: String, feeling: String, isRecommend: Bool, isPublic: Bool = false, countOfLike: Int = 0, peopleWhoLiked: [String] = []) {

        self.userIdentifier = userIdentifier
        self.nickname = nickname
        self.title = title
        self.text = text
        self.address = address
        self.category = category
        self.date = date
        self.feeling = feeling
        self.isRecommend = isRecommend
        self.isPublic = isPublic
        self.countOfLike = countOfLike
        self.peopleWhoLiked = peopleWhoLiked
    }
}

public struct SubmitReviewResponse: Codable {
    public let menuIdentifier: String
    public let userIdentifier: String
}

public struct SubmitImagesResponse: Codable {}

public struct CafeNamesResponse {
    public var names: [String]
}

public struct CafeCategoresResponse {
    public var names: [String]
}

public struct CafeMenusResponse {
    public var names: [String]
}

public struct ConvenienceStoreBrandsResponse {
    public var names: [String]
}

public struct ConvenienceStoreMenusResponse {
    public var names: [String]
}

public struct likeMenuRequest {
    public let type: String
    public let menuId: String
    public let writerId: String
    public let reviewerId: String
    public let countOfReviewLike: Int
}

public struct CheckRecordLikeRequest {
    public let type: String
    public let menuId: String
    public let reviewerId: String
}

public struct ReviewClient {
    public var submit: @Sendable (SubmitReviewRequest) async throws -> SubmitReviewResponse
    public var uploadImages: @Sendable (SubmitImagesRequest) async throws -> SubmitImagesResponse
    public var cafeNames: @Sendable () async throws -> CafeNamesResponse
    public var cafeMenus: @Sendable (String, String) async throws -> CafeMenusResponse
    public var cafeCategores: @Sendable (String) async throws -> CafeCategoresResponse
    public var convenienceStoreBrands: @Sendable () async throws -> ConvenienceStoreBrandsResponse
    public var convenienceStoreMenus: @Sendable (String) async throws -> ConvenienceStoreMenusResponse
    public var like: @Sendable (likeMenuRequest) async throws -> Bool
    public var isRecordLike: @Sendable (CheckRecordLikeRequest) async throws -> Bool
//    public var reviewDetail: @Sendable (likeMenuRequest) async throws -> Bool
}

extension ReviewClient: TestDependencyKey {
    public static let testValue = Self(
        submit: unimplemented("\(Self.self).submit"),
        uploadImages: unimplemented("\(Self.self).uploadImages"),
        cafeNames: unimplemented("\(Self.self).cafeNames"),
        cafeMenus: unimplemented("\(Self.self).cafeMenus"),
        cafeCategores: unimplemented("\(Self.self).cafeCategores"),
        convenienceStoreBrands: unimplemented("\(Self.self).convenienceStoreBrands"),
        convenienceStoreMenus: unimplemented("\(Self.self).convenienceStoreMenus"),
        like: unimplemented("\(Self.self).like"),
        isRecordLike: unimplemented("\(Self.self).checkRecordLike")
    )
}

extension DependencyValues {
    public var reviewClient: ReviewClient {
        get { self[ReviewClient.self] }
        set { self[ReviewClient.self] = newValue }
    }
}
