//
//  StoreSelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct StoreSelection: Reducer {
    public struct State: Equatable {
        public var selectedStore: Store?
        
        public init(selectedStore: Store? = nil) {
            self.selectedStore = selectedStore
        }
    }
    
    public enum Action {
        case select(Store)
    }
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .select(store):
            state.selectedStore = store
            return .none
        }
    }
}
