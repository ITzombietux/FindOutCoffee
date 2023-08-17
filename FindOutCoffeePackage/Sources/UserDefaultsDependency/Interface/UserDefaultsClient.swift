//
//  UserDefaultsClient.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

import Foundation

import Dependencies

extension DependencyValues {
    public var userDefaults: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}

public struct UserDefaultsClient {
    public var boolForKey: @Sendable (String) -> Bool
    public var remove: @Sendable (String) async -> Void
    public var setIdentifier: @Sendable (String, String) async -> Void
    
    public var isLoggedIn: Bool {
        self.boolForKey(isLoggedInKey)
    }
    
    public func setLoggedInKey(_ identifier: String) async {
        await self.setIdentifier(identifier, isLoggedInKey)
    }
}

public let isLoggedInKey = "isLoggedInKey"
