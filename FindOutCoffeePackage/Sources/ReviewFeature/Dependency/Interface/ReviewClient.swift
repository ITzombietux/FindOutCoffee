//
//  ReviewClient.swift
//  
//
//  Created by 10004 on 2023/08/16.
//

import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct LoginApiEntity: Sendable {
    public var identifier: String
    public var name: String
    public var imageURL: String
}

public struct ReviewClient {
    public var submitCafe: @Sendable (LoginApiEntity) async throws -> LoginApiEntity
    
    public init(
        login: @escaping @Sendable (LoginApiEntity) async throws -> LoginApiEntity) {
            self.login = login
        }
}

extension ReviewClient: TestDependencyKey {
    public static let testValue = Self(
        login: unimplemented("\(Self.self).login")
    )
}

extension DependencyValues {
    var reviewClient: ReviewClient {
        get { self[ReviewClient.self] }
        set { self[ReviewClient.self] = newValue }
    }
}
