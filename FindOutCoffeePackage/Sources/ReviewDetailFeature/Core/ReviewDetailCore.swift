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
        public var isRecordLiked: Bool = false
        
        public init(review: Review) {
            self.review = review
        }
    }
    
    public enum Action {
        case view(View)
        case recordLikeHistory(Bool)
        
        public enum View {
            case onAppear
            case likeButtonTapped
            case dismissButtonTapped
        }
    }
    
    public init() {}
    
    @Dependency(\.reviewClient) var reviewClient
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .view(.onAppear):
            return .run { [type = state.review.type, menuId = state.review.menuId] send in
                guard let reviewerId = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return }
                let checkRecordLikeRequest = CheckRecordLikeRequest(type: type, menuId: menuId, reviewerId: reviewerId)
                let isRecordLike = try await self.reviewClient.isRecordLike(checkRecordLikeRequest)
                await send(.recordLikeHistory(isRecordLike))
            }
            
        case .view(.likeButtonTapped):
            return .none
            
        case .view(.dismissButtonTapped):
            NotificationCenter.default.post(name: .dismissReviewDetailView, object: nil)
            return .none
            
        case .view:
            return .none
            
        case let .recordLikeHistory(isRecordLike):
            state.isRecordLiked = isRecordLike
            return .none
        }
    }
    
    public struct Review: Equatable {
        let type: String
        let menuId: String
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
        
        public init(type: String, menuId: String, coffeeName: String, imageURLs: [String], tags: [String], category: String, isRecommend: Bool, text: String, writer: String, date: String, countOfLike: Int, peopleWhoLiked: [String]) {
            self.type = type
            self.menuId = menuId
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
        
        public static let mock: Self = .init(type: "CafeReview",
                                             menuId: "",
                                             coffeeName: "혱구더블샷",
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
