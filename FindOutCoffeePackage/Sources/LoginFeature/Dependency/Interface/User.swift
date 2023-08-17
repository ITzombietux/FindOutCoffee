//
//  User.swift
//  
//
//  Created by 김혜지 on 2023/08/12.
//

public struct User {
    let id: String
    let profileImageURL: String?
    let nickname: String
    
    init?(
        id: String?,
        profileImageURL: String?,
        nickname: String?
    ) {
        guard let id = id, let nickname = nickname else { return nil }
        self.id = id
        self.profileImageURL = profileImageURL
        self.nickname = nickname
    }
}
