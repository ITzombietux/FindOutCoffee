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
             "imageURL" : request.imageURL,
             "type" : request.type
            ]
        )
        
        UserDefaults.standard.set(request.identifier, forKey: "isLoggedInKey")
        UserDefaults.standard.set(request.type, forKey: "typeKey")
        UserDefaults.standard.set(request.name, forKey: "nameKey")
        UserDefaults.standard.set(request.imageURL, forKey: "imageURLKey")
        
        return LoginApiEntity(identifier: request.identifier,
                              name: request.name,
                              imageURL: request.imageURL,
                              type: request.type)
    } user: {
        guard let identifier = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return .mock }
        let db = Firestore.firestore()
        var response = LoginApiEntity(identifier: "", name: "", imageURL: "", type: "")
        
        db.collection("Users").document(identifier).getDocument { (snapshot, error) in
            guard let name = snapshot?.data()?["nickname"] as? String else { return }
            guard let imageURL = snapshot?.data()?["imageURL"] as? String else { return }
            guard let type = snapshot?.data()?["type"] as? String else { return }
            
            response = LoginApiEntity(identifier: identifier, name: name, imageURL: imageURL, type: type)
        }
        
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return response
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
