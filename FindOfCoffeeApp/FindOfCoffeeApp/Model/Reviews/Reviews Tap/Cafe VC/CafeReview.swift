//
//  CafeReview.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import Foundation

struct CafeReview: Codable, Hashable, Equatable, Identifiable {
    let id: UUID = UUID()
    let menuIdentifier: String
    let userIdentifier: String
    let nickname: String
    let title: String
    let category: String
    let size: String
    let isHot: String
    let text: String
    let address: String
    var date: String
    let feeling: String
    let isRecommend: Bool
    let isPublic: Bool
    let thumbnail: [String]
    let countOfLike: Int
    let peopleWhoLiked: [String]
}
