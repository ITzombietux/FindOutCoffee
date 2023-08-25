//
//  CafeListDataLoader.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore

class CafeListDataLoader {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    typealias CafeReviewsHandler = (([CafeReview]) -> Void)
    var changeHandler: CafeReviewsHandler
    
    var cafeReviews: [CafeReview] = [] {
        didSet {
            changeHandler(cafeReviews)
        }
    }
    
    init(changeHandler: @escaping CafeReviewsHandler) {
        self.changeHandler = changeHandler
    }
    
    func getCafeReviews(title: String, kind: String) {
        db.collectionGroup("CafeReview").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.fetch(querySnapshot: querySnapshot!, title: title, kind: kind)
            }
        }
    }
    
    private func fetch(querySnapshot: QuerySnapshot, title: String, kind: String) { //스타벅스
        let dispatchGroup = DispatchGroup()
        var cafeReviews = [CafeReview]()
        
        querySnapshot.documents.forEach { document in
            dispatchGroup.enter()
            let data = document.data()
            
            self.getCafeReviewsImage(forder: data["id"] as! String) { imgs in
                dispatchGroup.leave()
                let cafeReview = CafeReview(
                    menuIdentifier: data["id"] as! String,
                    userIdentifier: data["userIdentifier"] as! String,
                    nickname: data["nickname"] as! String,
                    title: data["title"] as! String,
                    category: data["category"] as! String,
                    size: data["size"] as! String,
                    isHot: data["isHot"] as! String,
                    text: data["text"] as? String ?? "",
                    address: data["address"] as! String,
                    date: data["date"] as! String,
                    feeling: data["feeling"] as! String,
                    isRecommend: data["isRecommend"] as! Bool,
                    isPublic: data["isPublic"] as? Bool ?? true,
                    thumbnail: imgs)
                if cafeReview.isPublic {
                    cafeReviews.append(cafeReview)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            cafeReviews.forEach { cafeReview in
                
                switch kind {
                case "address":
                    let isEqual = (cafeReview.address == title)
                    
                    if isEqual {
                        self.cafeReviews.append(cafeReview)
                    } else {
                        self.cafeReviews.append(contentsOf: [])
                    }
                case "category":
                    let isEqual = (cafeReview.category == title)
                    
                    if isEqual {
                        self.cafeReviews.append(cafeReview)
                    } else {
                        self.cafeReviews.append(contentsOf: [])
                    }
                default:
                    break
                }
            }
        }
    }
    
    private func getCafeReviewsImage(forder: String, completion: @escaping (([String]) -> Void)) {
        let storageRef = storage.reference()
        let dispatchGroup = DispatchGroup()
        let storageImgCount = [1,2,3]
        var itemImgStrs = [String]()
        
        storageImgCount.forEach { count in
            dispatchGroup.enter()
            let imagesRef = storageRef.child("CafeReview").child(forder).child("\(forder)-\(count).jpeg").downloadURL { (url, error) in
                dispatchGroup.leave()

                if let urlString = url {
                    let urlStr = urlString.absoluteString
                    itemImgStrs.append(urlStr)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("##종료!!!")
            completion(itemImgStrs)
        }
    }
}
