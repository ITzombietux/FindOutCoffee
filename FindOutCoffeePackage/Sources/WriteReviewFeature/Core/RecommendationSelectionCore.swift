//
//  RecommendationSelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct RecommendationSelection: Reducer {
    public struct State: Equatable {
        public var isRecommend: Bool?
    }
    
    public enum Action {
        case select(Bool)
    }
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .select(isRecommend):
            state.isRecommend = isRecommend
            return .none
        }
    }
}
