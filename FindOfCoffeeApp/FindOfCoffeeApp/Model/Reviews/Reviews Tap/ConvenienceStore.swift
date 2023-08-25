//
//  ConvenienceStore.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation

struct ConvenienceStore: Codable, Hashable, Equatable, Identifiable {
    var id: UUID
    var menuIdentifier: String
    var userIdentifier: String
    var nickname: String
    var title: String
    var category: String
    var size: String
    var isHot: String
    var text: String
    var address: String
    var date: String
    let feeling: String
    let isRecommend: Bool
    let isPublic: Bool
    var thumbnail: [String]
    
    init(id: UUID = UUID(), menuIdentifier: String, userIdentifier: String, nickname: String, title: String, category: String, size: String, isHot: String, text: String, address: String, date: String, feeling: String, isRecommend: Bool, isPublic: Bool, thumbnail: [String]) {
        self.id = id
        self.menuIdentifier = menuIdentifier
        self.userIdentifier = userIdentifier
        self.nickname = nickname
        self.title = title
        self.category = category
        self.size = size
        self.isHot = isHot
        self.text = text
        self.address = address
        self.date = date
        self.feeling = feeling
        self.isRecommend = isRecommend
        self.isPublic = isPublic
        self.thumbnail = thumbnail
    }
}
