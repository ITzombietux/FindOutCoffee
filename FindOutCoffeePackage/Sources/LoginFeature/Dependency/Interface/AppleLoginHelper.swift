//
//  AppleLoginDelegate.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import AuthenticationServices

final public class AppleLoginHelper {
    public typealias Authorization = ASAuthorization
    public typealias AuthorizationResult = Result<Authorization, Error>
    
    private let appleIDCredential: ASAuthorizationAppleIDCredential
    
    init?(authorization: Authorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return nil }
        self.appleIDCredential = appleIDCredential
    }
    
    func loadUserInfomation() -> User? {
        guard let nickname = appleIDCredential.fullName?.nickname else { return nil }
        return User(id: appleIDCredential.user, profileImageURL: nil, nickname: nickname)
    }
}
