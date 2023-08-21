//
//  KakaoLoginDelegate.swift
//  
//
//  Created by 김혜지 on 2023/08/11.
//

import KakaoSDKAuth
import KakaoSDKUser

public struct KakaoLoginHelper {
    public typealias UserCompletion = (User?, Error?) -> Void
    
    public static func login(completion: @escaping UserCompletion) {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                if error != nil {
                    self.loginWithKakaoTalk { user, error in
                        completion(user, error)
                    }
                } else {
                    self.loadUserInfomation { user, error in
                        completion(user, error)
                    }
                }
            }
        } else {
            self.loginWithKakaoTalk { user, error in
                completion(user, error)
            }
        }
    }
    
    private static func loginWithKakaoTalk(completion: @escaping UserCompletion) {
        if UserApi.isKakaoTalkLoginAvailable() {
            self.loginWithApp { user, error in
                completion(user, error)
            }
        } else {
            self.loginWithWeb { user, error in
                completion(user, error)
            }
        }
    }
    
    private static func loginWithApp(completion: @escaping UserCompletion) {
        UserApi.shared.loginWithKakaoTalk { _, error in
            self.loadUserInfomation { user, error in
                completion(user, error)
            }
        }
    }
    
    private static func loginWithWeb(completion: @escaping UserCompletion) {
        UserApi.shared.loginWithKakaoAccount { _, error in
            self.loadUserInfomation { user, error in
                completion(user, error)
            }
        }
    }
    
    private static func loadUserInfomation(completion: @escaping UserCompletion) {
        UserApi.shared.me { user, error in
            let user: User? = User(id: user?.id?.description,
                                   profileImageURL: user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString,
                                   nickname: user?.kakaoAccount?.profile?.nickname)
            completion(user, error)
        }
    }
}
