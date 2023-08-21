//
//  ApiClient.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct LoginApiEntity: Sendable {
    public var identifier: String
    public var name: String
    public var imageURL: String
    
    public init(identifier: String, name: String, imageURL: String) {
        self.identifier = identifier
        self.name = name
        self.imageURL = imageURL
    }
}

public enum FirebaseLoginError: Equatable, LocalizedError, Sendable {
    case failureSave
    
    public var errorDescription: String? {
        switch self {
        case .failureSave:
            return "저장에 실패했습니다."
        }
    }
}

public struct LoginClient {
    public var login: @Sendable (LoginApiEntity) async throws -> LoginApiEntity
    
    public init(
        login: @escaping @Sendable (LoginApiEntity) async throws -> LoginApiEntity) {
            self.login = login
        }
}

extension LoginClient: TestDependencyKey {
    public static let testValue = Self(
        login: unimplemented("\(Self.self).login")
    )
}

extension DependencyValues {
    public var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}

