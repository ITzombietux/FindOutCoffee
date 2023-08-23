//
//  LoginClient.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

public struct AuthenticationClient {
    public var appleLogin: @Sendable (AppleLoginHelper.Authorization) async throws -> User
    public var kakaoLogin: @Sendable () async throws -> User
    
    public var logout: @Sendable (SNSLoginType) async throws -> Bool
}

extension DependencyValues {
    public var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
