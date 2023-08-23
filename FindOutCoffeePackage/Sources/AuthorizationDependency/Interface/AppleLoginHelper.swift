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
    
    public static func logout() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedOperation = .operationLogout
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
    }
    
    public func loadUser() -> User? {
        User(
            id: appleIDCredential.user,
            profileImageURL: nil,
            nickname: appleIDCredential.fullName?.nickname ?? "리뷰어",
            snsLoginType: .apple
        )
    }
}
