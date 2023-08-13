//
//  ReviewContentCore.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

struct ReviewContent: Reducer {
    enum Store: Equatable, CustomStringConvertible {
        case convenienceStore
        case cafe
        
        var description: String {
            switch self {
            case .convenienceStore:
                return "편의점"
            case .cafe:
                return "카페"
            }
        }
    }
    
    struct State: Equatable {
        var store: Store?
        
        init(store: Store? = nil) {
            self.store = store
        }
    }
    
    enum Action {
        case selectStore(Store)
    }
    
    init() {}
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .selectStore(store):
            state.store = store
            return .none
        }
    }
}
