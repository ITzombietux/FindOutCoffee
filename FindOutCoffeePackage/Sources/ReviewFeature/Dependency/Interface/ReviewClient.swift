//
//  ReviewClient.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct SubmitRequest: Codable, Identifiable {
    public var id = UUID()
    var coffee: Coffee
    var imageDatas: [Data]
    var selectedTitle: String
    var selectedStore: String?
}

public struct Coffee: Codable {
    var id: String
    var nickname: String
    var title: String
    var price: Int
    var taste: String
    var size: String
    var isHot: String
    var text: String
    var address: String
    var date: String
    var feeling: String
    var isRecommend: Bool
    var isPublic = false
    
    init(id: String, nickname: String, title: String, price: Int, taste: String, size: String, isHot: String, text: String, address: String, date: String, feeling: String, isRecommend: Bool) {
        self.id = id
        self.nickname = nickname
        self.title = title
        self.price = price
        self.taste = taste
        self.size = size
        self.isHot = isHot
        self.text = text
        self.address = address
        self.date = date
        self.feeling = feeling
        self.isRecommend = isRecommend
    }
}

public struct SubmitResponse: Codable {
    
}

public struct ReviewClient {
    public var submit: @Sendable (SubmitRequest) async throws -> SubmitResponse
    public var uploadImages: @Sendable (SubmitRequest) async throws -> SubmitResponse
    
    public init(
        submit: @escaping @Sendable (SubmitRequest) async throws -> SubmitResponse,
        uploadImages: @escaping @Sendable (SubmitRequest) async throws -> SubmitResponse
    ) {
        self.submit = submit
        self.uploadImages = uploadImages
    }
}

extension ReviewClient: TestDependencyKey {
    public static let testValue = Self(
        submit: unimplemented("\(Self.self).submit"),
        uploadImages: unimplemented("\(Self.self).uploadImages")
    )
}

extension DependencyValues {
    var reviewClient: ReviewClient {
        get { self[ReviewClient.self] }
        set { self[ReviewClient.self] = newValue }
    }
}
