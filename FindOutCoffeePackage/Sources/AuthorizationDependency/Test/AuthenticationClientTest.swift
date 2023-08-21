//
//  LoginClientTest.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import XCTestDynamicOverlay

extension AuthenticationClient {
    public static var testValue = Self(
        login: unimplemented("AuthenticationClient.login")
    )
}
