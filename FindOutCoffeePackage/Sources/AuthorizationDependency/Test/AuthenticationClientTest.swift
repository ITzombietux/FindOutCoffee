//
//  LoginClientTest.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import XCTestDynamicOverlay

extension AuthenticationClient {
    public static var testValue = Self(
        appleLogin: { _ in unimplemented("AuthenticationClient.appleLogin") },
        kakaoLogin: { unimplemented("AuthenticationClient.kakaoLogin") },
        logout: { _ in unimplemented("AuthenticationClient.logout") }
    )
}
