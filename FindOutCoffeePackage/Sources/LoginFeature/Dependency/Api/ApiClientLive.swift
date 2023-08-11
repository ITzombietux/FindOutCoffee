//
//  ApiClientLive.swift
//  
//
//  Created by 10004 on 2023/08/11.
//

import Dependencies
import FirebaseFirestoreSwift

extension ApiClient: DependencyKey {
    public static var liveValue = Self { request in
        return LoginApiEntity(identifier: "", name: "", imageURL: "")
    }
}
