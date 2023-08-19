//
//  LoginClient.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

public struct AuthenticationClient {
    public var login: @Sendable (SNSLoginType) async throws -> User
}

extension DependencyValues {
    public var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
