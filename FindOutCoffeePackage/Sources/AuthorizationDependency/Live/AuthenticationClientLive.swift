//
//  LoginClientLive.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

extension AuthenticationClient: DependencyKey {
    public static var liveValue = Self { authorization in
        try await withCheckedThrowingContinuation { continuation in
            guard let helper = AppleLoginHelper(authorization: authorization) else { return }
            guard let user = helper.loadUser() else { return }
            continuation.resume(returning: user)
        }
    } kakaoLogin: {
        try await withCheckedThrowingContinuation { continuation in
            KakaoLoginHelper.login { user, error in
                guard let user = user else { return }
                continuation.resume(returning: user)
                
                guard let error = error else { return }
                continuation.resume(throwing: error)
            }
        }
    } logout: { snsLoginType in
        switch snsLoginType {
        case .apple:
            AppleLoginHelper.logout()
            return true
            
        case .kakao:
            return await withCheckedContinuation { continuation in
                KakaoLoginHelper.logout { isSuccess in
                    continuation.resume(returning: isSuccess)
                }
            }
        }
    }
}
