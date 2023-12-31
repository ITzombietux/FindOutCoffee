//
//  ConvenienceStoreDataLoader.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/24.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore

class ConvenienceStoreDataLoader {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    typealias ConvienienceStoresHandler = (([ConvenienceStore]) -> Void)
    var changeHandler: ConvienienceStoresHandler
    
    var convienienceStores: [ConvenienceStore] = [] {
        didSet {
            changeHandler(convienienceStores)
        }
    }
    
    init(changeHandler: @escaping ConvienienceStoresHandler) {
        self.changeHandler = changeHandler
    }
    
    func getConvienienceStores() {
        db.collection("CSReview").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.fetch(querySnapshot: querySnapshot!)
            }
        }
    }
    
    func fetch(querySnapshot: QuerySnapshot) {
        let dispatchGroup = DispatchGroup()
        var convienienceStores = [ConvenienceStore]()
        
        querySnapshot.documents.forEach { document in
            dispatchGroup.enter()
            let data = document.data()
            
            self.getConvienienceStoresImage(forder: data["id"] as! String) { imgs in
                dispatchGroup.leave()
                let convienienceStore = ConvenienceStore(
                    type: "CSReview",
                    menuIdentifier: data["id"] as? String ?? "",
                    userIdentifier: data["userIdentifier"] as? String ?? "",
                    nickname: data["nickname"] as? String ?? "",
                    title: data["title"] as? String ?? "",
                    category: data["category"] as? String ?? "",
                    size: data["size"] as? String ?? "",
                    isHot: data["isHot"] as? String ?? "",
                    text: data["text"] as? String ?? "",
                    address: data["address"] as? String ?? "",
                    date: data["date"] as? String ?? "",
                    feeling: data["feeling"] as? String ?? "",
                    isRecommend: data["isRecommend"] as? Bool ?? true,
                    isPublic: data["isPublic"] as? Bool ?? false,
                    thumbnail: imgs,
                    countOfLike: data["countOfLike"] as? Int ?? 0,
                    peopleWhoLiked: data["peopleWhoLiked"] as? [String] ?? [])
                
                if convienienceStore.isPublic {
                    convienienceStores.append(convienienceStore)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.convienienceStores = convienienceStores
        }
    }
    
    private func getConvienienceStoresImage(forder: String, completion: @escaping (([String]) -> Void)) {
        let storageRef = storage.reference()
        let dispatchGroup = DispatchGroup()
        let storageImgCount = [1,2,3]
        var itemImgStrs = [String]()
        
        storageImgCount.forEach { count in
            dispatchGroup.enter()
            let imagesRef = storageRef.child("CSReview").child(forder).child("\(forder)-\(count).jpeg").downloadURL { (url, error) in
                dispatchGroup.leave()
//                if error != nil {
//                    print(error?.localizedDescription)
//                    return
//                    completion([])
//                }

                if let urlString = url {
                    let urlStr = urlString.absoluteString
                    itemImgStrs.append(urlStr)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(itemImgStrs)
        }
    }
}
