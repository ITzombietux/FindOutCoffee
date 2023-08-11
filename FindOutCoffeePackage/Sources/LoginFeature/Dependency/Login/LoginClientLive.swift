//
//  LoginClientLive.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import Dependencies

extension LoginClient: DependencyKey {
    public static var liveValue: Self = {
        return Self(
            apple: {
                let stream = AsyncThrowingStream<String, Error> { continuation in
                    let delegate = AppleLoginDelegate { email in
                        continuation.yield(email)
                        continuation.finish()
                    } didCompleteWithError: { error in
                        continuation.finish(throwing: error)
                    }
                }
            }
        )
    }()
}
