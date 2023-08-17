//
//  SNSLoginType.swift
//  
//
//  Created by 김혜지 on 2023/08/12.
//

extension AuthenticationClient {
    enum SNSLoginType {
        case apple(AppleLoginHelper.Authorization)
        case kakao
    }
}
