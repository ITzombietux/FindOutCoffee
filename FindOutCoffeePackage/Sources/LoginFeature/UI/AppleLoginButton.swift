//
//  AppleLoginButton.swift
//  
//
//  Created by 김혜지 on 2023/08/12.
//

import AuthenticationServices
import AuthorizationDependency
import SwiftUI

public struct AppleLoginButton: View {
    public typealias AuthorizationCompletion = (AppleLoginHelper.AuthorizationResult) -> Void
    
    @Environment(\.colorScheme) var currentScheme
    private let action: AuthorizationCompletion
    
    public init(action: @escaping AuthorizationCompletion) {
        self.action = action
    }
    
    public var body: some View {
        SignInWithAppleButton { request in
            request.requestedScopes = [.fullName]
        } onCompletion: { result in
            switch result {
            case let .success(authorization):
                guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                action(.success(authorization))
            case let .failure(error):
                break
            }
        }
        .signInWithAppleButtonStyle(currentScheme == .light ? .black : .white)
    }
}

struct AppleLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginButton { _ in
            
        }
    }
}
