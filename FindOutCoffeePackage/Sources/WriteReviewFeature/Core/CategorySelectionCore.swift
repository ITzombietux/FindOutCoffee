//
//  CategorySelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct CategorySelection: Reducer {
    public struct State: Equatable {
        public var categories: [String]
        public var selectedIndex: Int?
        public var selectedCategory: String? {
            guard let selectedIndex = self.selectedIndex else { return nil }
            return self.categories[selectedIndex]
        }
        
        public init(categories: [String] = [], selectedIndex: Int? = nil) {
            self.categories = categories
            self.selectedIndex = selectedIndex
        }
    }
    
    public enum Action {
        case load(String)
        case loadResponse(TaskResult<CafeCategoresResponse>)
        case select(Int)
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .load(brand):
            return .run { send in
                await send(
                    .loadResponse(
                        await TaskResult {
                            try await self.reviewClient.cafeCategores(brand)
                        }
                    )
                )
            }
            
        case let .loadResponse(.success(response)):
            state.categories = response.names
            return .none
            
        case let .loadResponse(.failure(error)):
            return .none
            
        case let .select(index):
            state.selectedIndex = index
            return .none
        }
    }
}
