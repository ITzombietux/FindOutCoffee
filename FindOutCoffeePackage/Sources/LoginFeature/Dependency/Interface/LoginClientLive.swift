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

extension loginClient: DependencyKey {
    public static var liveValue = Self { request in
        let db = Firestore.firestore()
        db.collection("User").document(request.identifier).setData(
            ["nickname" : request.name,
             "imageURL" : request.imageURL
            ]
        ) { error in
            if error == nil {
                
            } else {
                
            }
        }
        
        return LoginApiEntity(identifier: request.identifier,
                              name: request.name,
                              imageURL: request.imageURL)
    }
}

