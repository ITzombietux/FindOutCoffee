//
//  ConvenienceStore.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation

struct ConvenienceStore: Codable, Hashable, Equatable {
    var id: String
    var nickname: String
    var title: String
    var price: Int
    var taste: String
    var size: String
    var isHot: String
    var text: String
    var address: String
    var date: String
    var thumbnail: [String]
    
    init(id: String, nickname: String, title: String, price: Int, taste: String, size: String, isHot: String, text: String, address: String, date: String, thumbnail: [String]) {
        self.id = id
        self.nickname = nickname
        self.title = title
        self.price = price
        self.taste = taste
        self.size = size
        self.isHot = isHot
        self.text = text
        self.address = address
        self.date = date
        self.thumbnail = thumbnail
    }
}
