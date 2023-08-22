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
    public var type: String // kakao or apple
    
    public init(identifier: String, name: String, imageURL: String, type: String) {
        self.identifier = identifier
        self.name = name
        self.imageURL = imageURL
        self.type = type
    }
    
    public static let mock: Self = .init(identifier: "", name: "", imageURL: "", type: "")
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

func removeUser() {
    UserDefaults.standard.removeObject(forKey: "isLoggedInKey")
    UserDefaults.standard.removeObject(forKey: "tpyeKey")
    UserDefaults.standard.removeObject(forKey: "nameKey")
    UserDefaults.standard.removeObject(forKey: "imageURLKey")
}

public struct LoginClient {
    public var login: @Sendable (LoginApiEntity) async throws -> LoginApiEntity
    public var user: @Sendable () async throws -> LoginApiEntity
    public var logout: @Sendable () async throws -> Bool
    public var withdrawal: @Sendable () async throws -> Bool
}

extension LoginClient: TestDependencyKey {
    public static let testValue = Self(
        login: unimplemented("\(Self.self).login"),
        user: unimplemented("\(Self.self).user"),
        logout: unimplemented("\(Self.self).logout"),
        withdrawal: unimplemented("\(Self.self).withdrawal")
    )
}

extension DependencyValues {
    public var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}

