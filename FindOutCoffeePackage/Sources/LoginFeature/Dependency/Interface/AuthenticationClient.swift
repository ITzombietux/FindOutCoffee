//
//  LoginClient.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

struct AuthenticationClient {
    var login: @Sendable (SNSLoginType) async throws -> User
}

extension DependencyValues {
    var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
