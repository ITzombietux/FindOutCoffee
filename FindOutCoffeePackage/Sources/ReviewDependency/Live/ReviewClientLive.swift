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
            
            db.collection(request.selectedTitle).document(request.id.uuidString).setData(
                ["id" : request.id.uuidString,
                 "userIdentifier" : request.coffee.userIdentifier,
                 "nickname" : request.coffee.nickname,
                 "title" : request.coffee.title,
                 "category" : request.coffee.category,
                 "text" : request.coffee.text,
                 "address" : request.coffee.address,
                 "date" : request.coffee.date,
                 "feeling" : request.coffee.feeling,
                 "isRecommend" : request.coffee.isRecommend,
                 "isPublic" : request.coffee.isPublic,
                 "countOfLike" : request.coffee.countOfLike,
                 "peopleWhoLiked" : request.coffee.peopleWhoLiked
                ]
            ) { error in
                if error == nil {
                    
                } else {
                    
                }
            }
            
            return SubmitReviewResponse(menuIdentifier: request.id.uuidString,
                                        userIdentifier: request.coffee.userIdentifier)
        },
        uploadImages: { request in
            let storageRef = Storage.storage().reference()
            var images: [UIImage] = []
            
            request.photosData.forEach { imageData in
                if let image = imageData.image {
                    images.append(image)
                }
            }
            
            images.forEach { image in
                let imageData = image.jpegData(compressionQuality: 0.6)!
                let imageName = NSUUID().uuidString + ".jpg"
                let imageRef = storageRef.child("\(request.menuIdentifier)").child(imageName)
                
                imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if error == nil {
                        // The image was stored successfully
                    } else {
                        // An error occurred
                    }
                }
            }
            
            return SubmitImagesResponse()
        },
        cafeNames: {
            let db = Firestore.firestore()
            var response = CafeNamesResponse(names: [])
            
            db.collectionGroup("CafeList").getDocuments { (querySnapshot, error) in
                querySnapshot?.documents.forEach { document in
                    response.names.append(document.documentID)
                }
            }
            
            response.names.sort(by: { a, b in
                return a.compare(b) == .orderedAscending
            })
            
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
                
                response.names = menus
            }
            response.names.sort(by: { a, b in
                return a.compare(b) == .orderedAscending
            })
            
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
            response.names.sort(by: { a, b in
                return a.compare(b) == .orderedAscending
            })
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return response
        },
        convenienceStoreBrands: {
            let db = Firestore.firestore()
            var response = ConvenienceStoreBrandsResponse(names: [])
            
            db.collectionGroup("CSMenus").getDocuments { (querySnapshot, error) in
                querySnapshot?.documents.forEach { document in
                    document.data().forEach { (key, value) in
                        response.names.append(key)
                    }
                }
            }
            response.names.sort(by: { a, b in
                return a.compare(b) == .orderedAscending
            })
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return response
        },
        convenienceStoreMenus: { brand in
            let db = Firestore.firestore()
            var response = ConvenienceStoreMenusResponse(names: [])
            
            db.collectionGroup("CSMenus").getDocuments { (querySnapshot, error) in
                querySnapshot?.documents.forEach { document in
                    guard let menus = document.data()[brand] as? [String] else { return }
                    response.names = menus
                }
            }
            response.names.sort(by: { a, b in
                return a.compare(b) == .orderedAscending
            })
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return response
        },
        like: { request in
            let db = Firestore.firestore()
            let parameter = request.isRecordLiked ? ["countOfLike": request.countOfReviewLike,
                                                      "peopleWhoLiked" : FieldValue.arrayRemove([request.reviewerId])] : ["countOfLike": request.countOfReviewLike,
                                                                                                                          "peopleWhoLiked" : FieldValue.arrayUnion([request.reviewerId])]
            
            
            try await db.collection(request.type).document(request.menuId).updateData(parameter) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Array field updated successfully!")
                }
            }
            
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return request.isRecordLiked ? false : true
        },
        isRecordLike: { request in
            let db = Firestore.firestore()
                .collection(request.type)
                .document(request.menuId)
            
            var isRecordLike: Bool = false
            
            await db.getDocument { (document, error) in
                guard let peopleWhoLikedIds = document?.data()?["peopleWhoLiked"] as? [String] else { return }
                
                peopleWhoLikedIds.forEach { peopleWhoLikedId in
                    if peopleWhoLikedId == request.reviewerId {
                        isRecordLike = true
                    }
                }
            }

            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            return isRecordLike 
        }
    )
}
