//
//  CafeReview.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import Foundation

struct CafeReview: Codable, Hashable, Equatable {
    let id: String
    let nickname: String
    let title: String
    let price: Int
    let taste: String
    let size: String
    let isHot: String
    let text: String
    let address: String
    var date: String
    let feeling: String
    let isRecommend: Bool
    let isPublic: Bool
    let thumbnail: [String]
}
