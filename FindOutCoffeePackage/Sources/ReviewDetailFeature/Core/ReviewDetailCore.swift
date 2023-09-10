//
//  ReviewDetailCore.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import ComposableArchitecture

public struct ReviewDetail: Reducer {
    public struct State: Equatable {
        let review: Review = .mock
        
        public init() {}
    }
    
    public enum Action {
        case like
    }
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .like:
            return .none
        }
    }
    
    struct Review: Equatable {
        let coffeeName: String
        let imageURLs: [String]
        let tags: [String]
        let category: String
        let isRecommend: Bool
        let text: String
        let writer: String
        let date: String
        let likes: [String]
        
        public static let mock: Self = .init(coffeeName: "혱구더블샷",
                                             imageURLs: ["", "", ""],
                                             tags: ["🥰비싸지만 맛있어요", "✨구하기 힘들어요"],
                                             category: "만구꺼",
                                             isRecommend: true,
                                             text: "혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요. 혱구더블샷은 만구만 맛볼 수 있어요.",
                                             writer: "그멩구",
                                             date: "2023.09.10",
                                             likes: ["mangu", "mansa", "10004"])
    }
}
