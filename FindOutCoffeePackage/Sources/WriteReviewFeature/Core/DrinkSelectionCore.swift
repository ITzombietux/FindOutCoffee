//
//  DrinkSelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct DrinkSelection: Reducer {
    public struct State: Equatable {
        public var isEnabledToAdd: Bool
        public var writtenDrink: String
        public var drinks: [String]
        public var selectedIndex: Int?
        public var selectedDrink: String? {
            if let selectedIndex = self.selectedIndex {
                return self.drinks[selectedIndex]
            }
            
            if self.writtenDrink != "" {
                return self.writtenDrink
            }
            
            return nil
        }
        
        public init(isEnabledToAdd: Bool = false, writtenDrink: String = "", drinks: [String] = [], selectedIndex: Int? = nil) {
            self.isEnabledToAdd = isEnabledToAdd
            self.writtenDrink = writtenDrink
            self.drinks = drinks
            self.selectedIndex = selectedIndex
        }
    }
    
    public enum Action {
        case load(Store)
        case loadCafeDrinksResponse(TaskResult<CafeMenusResponse>)
        case loadConvenienceStoreDrinksResponse(TaskResult<ConvenienceStoreMenusResponse>)
        case select(Int)
        case addButtonTapped
        case writeDrink(String)
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .load(store):
            switch store {
            case .cafe:
                return .run { send in
                    await send(
                        .loadCafeDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.cafeMenus("brand", "category")
                            }
                        )
                    )
                }
            case .convenienceStore:
                return .run { send in
                    await send(
                        .loadConvenienceStoreDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.convenienceStoreMenus("brand")
                            }
                        )
                    )
                }
            }
            
        case let .loadCafeDrinksResponse(.success(response)):
            state.drinks = response.names
            return .none
            
        case let .loadCafeDrinksResponse(.failure(error)):
            return .none
            
        case let .loadConvenienceStoreDrinksResponse(.success(response)):
            state.drinks = response.names
            return .none
            
        case let .loadConvenienceStoreDrinksResponse(.failure(error)):
            return .none
            
        case let .select(index):
            state.selectedIndex = index
            return .none
            
        case .addButtonTapped:
            state.isEnabledToAdd = true
            return .none
            
        case let .writeDrink(input):
            state.writtenDrink = input
            return .none
        }
    }
}
