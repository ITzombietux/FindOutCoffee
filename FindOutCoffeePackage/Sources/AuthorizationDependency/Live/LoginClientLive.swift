//
//  LoginClientLive.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Foundation
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
                              imageURL: request.imageURL,
                              type: request.type)
    } user: {
        guard let identifier = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return .mock }
        guard let type = UserDefaults.standard.string(forKey: "tpyeKey") else { return .mock }
        guard let name = UserDefaults.standard.string(forKey: "nameKey") else { return .mock }
        guard let imageURL = UserDefaults.standard.string(forKey: "imageURLKey") else { return .mock }
        
        return LoginApiEntity(identifier: identifier,
                              name: name,
                              imageURL: imageURL,
                              type: type)
    } logout: {
        removeUser()
        
        return true
    } withdrawal: {
        guard let identifier = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return false }
        let db = Firestore.firestore()
        
        db.collection("Users").document(identifier).delete()
        removeUser()
        
        return true
    }
}
