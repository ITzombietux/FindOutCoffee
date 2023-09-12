//
//  ReviewDetailCore.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import Foundation

import ComposableArchitecture
import ReviewDependency

public struct ReviewDetail: Reducer {
    public struct State: Equatable {
        let review: Review
        
        public init(review: Review) {
            self.review = review
        }
    }
    
    public enum Action {
        case view(View)
        
        
        public enum View {
            case likeButtonTapped
            case dismissButtonTapped
        }
    }
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .view(.likeButtonTapped):
            return .none
            
        case .view(.dismissButtonTapped):
            NotificationCenter.default.post(name: .dismissReviewDetailView, object: nil)
            return .none
        }
    }
    
    public struct Review: Equatable {
        let coffeeName: String
        let imageURLs: [String]
        let tags: [String]
        let category: String
        let isRecommend: Bool
        let text: String
        let writer: String
        let date: String
        let countOfLike: Int
        let peopleWhoLiked: [String]
        
        public init(coffeeName: String, imageURLs: [String], tags: [String], category: String, isRecommend: Bool, text: String, writer: String, date: String, countOfLike: Int, peopleWhoLiked: [String]) {
            self.coffeeName = coffeeName
            self.imageURLs = imageURLs
            self.tags = tags
            self.category = category
            self.isRecommend = isRecommend
            self.text = text
            self.writer = writer
            self.date = date
            self.countOfLike = countOfLike
            self.peopleWhoLiked = peopleWhoLiked
        }
        
        public static let mock: Self = .init(coffeeName: "혱구더블샷",
                                             imageURLs: ["", "", ""],
                                             tags: ["🥰비싸지만 맛있어요", "✨구하기 힘들어요"],
                                             category: "만구꺼",
                                             isRecommend: true,
                                             text: "혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요.",
                                             writer: "그멩구",
                                             date: "2023.09.10",
                                             countOfLike: 311,
                                             peopleWhoLiked: ["만구, 혱구"])
    }
}
