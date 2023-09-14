//
//  BrandSelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct BrandSelection: Reducer {
    public struct State: Equatable {
        public var brands: [String]
        public var selectedIndex: Int?
        public var selectedBrand: String? {
            guard let selectedIndex = self.selectedIndex else { return nil }
            return self.brands[selectedIndex]
        }
        
        public init(brands: [String] = [], selectedIndex: Int? = nil) {
            self.brands = brands
            self.selectedIndex = selectedIndex
        }
    }
    
    public enum Action {
        case load(Store)
        case loadCafeBrandsResponse(TaskResult<CafeNamesResponse>)
        case loadConvenienceStoreBrandsResponse(TaskResult<ConvenienceStoreBrandsResponse>)
        case select(Int)
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
                        .loadCafeBrandsResponse(
                            await TaskResult {
                                try await self.reviewClient.cafeNames()
                            }
                        )
                    )
                }
                
            case .convenienceStore:
                return .run { send in
                    await send(
                        .loadConvenienceStoreBrandsResponse(
                            await TaskResult {
                                try await self.reviewClient.convenienceStoreBrands()
                            }
                        )
                    )
                }
            }
            
        case let .loadCafeBrandsResponse(.success(response)):
            state.brands = response.names
            return .none
            
        case let .loadCafeBrandsResponse(.failure(error)):
            return .none
            
        case let .loadConvenienceStoreBrandsResponse(.success(response)):
            state.brands = response.names
            return .none
            
        case let .loadConvenienceStoreBrandsResponse(.failure(error)):
            return .none
            
        case let .select(index):
            state.selectedIndex = index
            return .none
        }
    }
}
