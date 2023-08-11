//
//  LoginClientLive.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

extension AuthenticationClient: DependencyKey {
    public static var liveValue: Self = {
        return Self(
            login: { snsLoginType in
                switch snsLoginType {
                case .apple:
                    return try await withCheckedThrowingContinuation { continuation in
                        let delegate = AppleLoginHelper { email in
                            
                        } didCompleteWithError: { error in
                            continuation.resume(throwing: error)
                        }
                    }
                case .kakao:
                    return try await withCheckedThrowingContinuation { continuation in
                        KakaoLoginHelper.login { user, error in
                            guard let user = user else { return }
                            continuation.resume(returning: user)
                            
                            guard let error = error else { return }
                            continuation.resume(throwing: error)
                        }
                    }
                }
            }
        )
    }()
}
