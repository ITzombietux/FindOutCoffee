//
//  LoginClientLive.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

extension LoginClient: DependencyKey {
    public static var liveValue = Self { request in
        let db = Firestore.firestore()
        db.collection("Users").document(request.identifier).setData(
            ["nickname" : request.name,
             "imageURL" : request.imageURL
            ]
        )
        
        return LoginApiEntity(identifier: request.identifier,
                              name: request.name,
                              imageURL: request.imageURL)
    }
}

