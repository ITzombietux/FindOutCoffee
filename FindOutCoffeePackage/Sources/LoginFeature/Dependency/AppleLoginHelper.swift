//
//  AppleLoginDelegate.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import AuthenticationServices

final class AppleLoginHelper: NSObject, ASAuthorizationControllerDelegate {
    private let provider = ASAuthorizationAppleIDProvider()
    let didCompleteWithAuthorization: (String) -> ()
    let didCompleteWithError: (Error) -> ()
    
    init(
        didCompleteWithAuthorization: @escaping (String) -> (),
        didCompleteWithError: @escaping (Error) -> ()
    ) {
        self.didCompleteWithAuthorization = didCompleteWithAuthorization
        self.didCompleteWithError = didCompleteWithError
    }
    
    func getCredentialState(userID: String) {
        self.provider.getCredentialState(forUserID: userID) { credentialState, error in
            switch credentialState {
            case .revoked:
                break
                
            case .authorized:
                break
                
            case .notFound:
                break
                
            case .transferred:
                break
                
            @unknown default:
                fatalError()
                break
            }
        }
    }
    
    func request() {
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let fullName = appleIDCredential.fullName,
              let email = appleIDCredential.email else { return }
        let userIdentifier = appleIDCredential.user
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}
