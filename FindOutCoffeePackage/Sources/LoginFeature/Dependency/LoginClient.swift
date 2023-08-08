//
//  LoginClient.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

struct LoginClient {
    var apple: () -> Void
}

extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
