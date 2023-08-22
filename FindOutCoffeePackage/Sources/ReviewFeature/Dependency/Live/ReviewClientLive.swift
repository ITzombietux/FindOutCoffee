//
//  ReviewClientLive.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Dependencies
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestoreSwift
import UIKit.UIImage

extension ReviewClient: DependencyKey {
    public static let liveValue = Self(
        submit: { request in
            let db = Firestore.firestore()
            
            db.collection(request.selectedTitle).document("\(request.userIdentifier)").setData(
                ["id" : "\(request.id)",
                 "nickname" : request.coffee.nickname,
                 "title" : request.coffee.title,
                 "price" : request.coffee.price,
                 "taste" : request.coffee.taste,
                 "size" : request.coffee.size,
                 "isHot" : request.coffee.isHot,
                 "text" : request.coffee.text,
                 "address" : request.coffee.address,
                 "date" : request.coffee.date,
                 "feeling" : request.coffee.feeling,
                 "isRecommend" : request.coffee.isRecommend
                ]
            ) { error in
                if error == nil {
                    
                } else {
                    
                }
            }
            
            return SubmitResponse()
        },
        uploadImages: { request in
            let storageRef = Storage.storage().reference()
            var images: [UIImage] = []
            
            request.imageDatas.forEach { imageData in
                if let image = imageData.image {
                    images.append(image)
                }
            }
            
            images.forEach { image in
                let imageData = image.jpegData(compressionQuality: 0.8)!
                let imageName = NSUUID().uuidString + ".jpg"
                let imageRef = storageRef.child("images").child(imageName)
                
                imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if error == nil {
                        // The image was stored successfully
                        print("Image stored successfully")
                    } else {
                        // An error occurred
                        print(error!)
                    }
                }
            }
            
            return SubmitResponse()
        },
        cafeNames: {
            let db = Firestore.firestore()
            var response = CafeNamesResponse(names: [])
            
            db.collectionGroup("CafeList").getDocuments { (querySnapshot, error) in
                querySnapshot?.documents.forEach { document in
                    response.names.append(document.documentID)
                }
            }
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return response
        },
        cafeMenus: { cafeName, cafeCategory in
            let db = Firestore.firestore()
            var response = CafeMenusResponse(names: [])
            
            db.collection("CafeMenus").document(cafeName).getDocument { (snapshot, error) in
                guard let categoryDictionary = snapshot?.data() else { return }
                guard let categoryValues = categoryDictionary[cafeCategory] else { return }
                guard let menus = categoryValues as? [String] else { return }
                
                print("#####", menus)
                response.names = menus
            }
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return response
        },
        cafeCategores: { cafeName in
            let db = Firestore.firestore()
            var response = CafeCategoresResponse(names: [])
            
            db.collection("CafeMenus").document(cafeName).getDocument { (snapshot, error) in
                guard let categoryKeys = snapshot?.data() else { return }
                categoryKeys.keys.forEach { categoryName in
                    response.names.append(categoryName)
                }
            }
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            print("######", response)
            return response
        },
        convenienceStoreMenus: {
            let db = Firestore.firestore()
            var response = ConvenienceStoreMenusResponse(names: [])
            
            db.collectionGroup("CSMenus").getDocuments { (querySnapshot, error) in
                querySnapshot?.documents.forEach { document in
                    response.names.append(document.documentID)
                }
            }
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            print("######", response)
            return response
        }
    )
}
