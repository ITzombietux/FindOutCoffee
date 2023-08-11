//
//  ApiClient.swift
//  
//
//  Created by 10004 on 2023/08/11.
//

import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct LoginApiEntity: Sendable {
    public var identifier: String
    public var name: String
    public var imageURL: String
}

public struct ApiClient {
    public var login: @Sendable (LoginApiEntity) async throws -> LoginApiEntity
    
    public init(
        login: @escaping @Sendable (LoginApiEntity) async throws -> LoginApiEntity) {
            self.login = login
        }
}

extension ApiClient: TestDependencyKey {
    public static let testValue = Self(
        login: unimplemented("\(Self.self).login")
    )
}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}
