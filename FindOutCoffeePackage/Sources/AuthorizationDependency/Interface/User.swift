//
//  User.swift
//  
//
//  Created by 김혜지 on 2023/08/12.
//

public struct User {
    public let id: String
    public let profileImageURL: String?
    public let nickname: String
    public let snsLoginType: SNSLoginType
    
    public init?(
        id: String?,
        profileImageURL: String?,
        nickname: String?,
        snsLoginType: SNSLoginType
    ) {
        guard let id = id, let nickname = nickname else { return nil }
        self.id = id
        self.profileImageURL = profileImageURL
        self.nickname = nickname
        self.snsLoginType = snsLoginType
    }
}
