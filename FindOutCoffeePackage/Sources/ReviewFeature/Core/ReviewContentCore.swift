//
//  ReviewContentCore.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

import Foundation

public struct ReviewContent: Reducer {
    public struct State: Equatable {
        public var brands: [String]?
        public var categories: [String]?
        public var drinks: [String]?
        public var prices: [String]?
        public var store: Store?
        public var brand: String?
        public var category: String?
        public var drink: String?
        public var iceOrHot: IceOrHot?
        public var price: String?
        public var isRecommend: Bool?
        public var photo: [Data]?
        public var text: String?
        
        public init(brands: [String]? = nil, categories: [String]? = nil, drinks: [String]? = nil, prices: [String]? = nil, store: Store? = nil, brand: String? = nil, category: String? = nil, drink: String? = nil, iceOrHot: IceOrHot? = nil, price: String? = nil, isRecommend: Bool? = nil, photo: [Data]? = nil, text: String? = nil) {
            self.brands = brands
            self.categories = categories
            self.drinks = drinks
            self.prices = prices
            self.store = store
            self.brand = brand
            self.category = category
            self.drink = drink
            self.iceOrHot = iceOrHot
            self.price = price
            self.isRecommend = isRecommend
            self.photo = photo
            self.text = text
        }
    }
    
    public enum Action {
        case load(Review.Step)
        case loadBrands
        case loadCategories
        case loadDrinks
        case loadPrices
        case completeLoading
        case selectStore(Store)
        case selectBrand(String)
        case selectCategory(String)
        case selectDrink(String)
        case selectIceOrHot(IceOrHot)
        case selectPrice(String)
        case selectRecommendation(Bool)
        case selectPhoto([Data])
        case editText(String)
        case loadBrandsResponse(TaskResult<CafeNamesResponse>)
        case loadCafeDrinksResponse(TaskResult<CafeMenusResponse>)
        case loadConvenienceStoreDrinksResponse(TaskResult<ConvenienceStoreMenusResponse>)
        case loadCategoriesResponse(TaskResult<CafeCategoresResponse>)
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .load(step):
            switch step {
            case .brand:
                return .send(.loadBrands)
            case .category:
                return .send(.loadCategories)
            case .drink:
                return .send(.loadDrinks)
            default:
                return .none
            }
            
        case .loadBrands:
            return .run { send in
                await send(
                    .loadBrandsResponse(
                        await TaskResult {
                            try await self.reviewClient.cafeNames()
                        }
                    )
                )
            }
            
        case .loadBrandsResponse(.success(let response)):
            state.brands = response.names
            return .send(.completeLoading)
            
        case .loadBrandsResponse(.failure(let error)):
            return .none
            
        case .loadCategories:
            guard let brand = state.brand else { return .none }
            
            return .run { send in
                await send(
                    .loadCategoriesResponse(
                        await TaskResult {
                            try await self.reviewClient.cafeCategores(brand)
                        }
                    )
                )
            }
            
        case .loadCategoriesResponse(.success(let response)):
            state.categories = response.names
            return .send(.completeLoading)
            
        case .loadCategoriesResponse(.failure(let error)):
            return .none
            
        case .loadDrinks:
            guard let store = state.store else { return .none }
            switch store {
            case .cafe:
                guard let brand = state.brand else { return .none }
                guard let category = state.category else { return .none }
                return .run { send in
                    await send(
                        .loadCafeDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.cafeMenus(brand, category)
                            }
                        )
                    )
                }
            case .convenienceStore:
                return .run { send in
                    await send(
                        .loadConvenienceStoreDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.convenienceStoreMenus()
                            }
                        )
                    )
                }
            }
            
        case .loadCafeDrinksResponse(.success(let response)):
            state.drinks = response.names
            return .send(.completeLoading)
            
        case .loadCafeDrinksResponse(.failure(let error)):
            return .none
            
        case .loadConvenienceStoreDrinksResponse(.success(let response)):
            state.drinks = response.names
            return .send(.completeLoading)
            
        case .loadConvenienceStoreDrinksResponse(.failure(let error)):
            return .none
            
        case .loadPrices:
            state.prices = ["너무 비싸요", "비싸지만 맛있어요"]
            return .none
            
        case .completeLoading:
            return .none
            
        case let .selectStore(store):
            state.store = store
            if store == .convenienceStore {
                state.brand = nil
                state.categories = nil
            }
            return .none
            
        case let .selectBrand(brand):
            state.brand = brand
            return .none
            
        case let .selectCategory(category):
            state.category = category
            return .none
            
        case let .selectDrink(drink):
            state.drink = drink
            return .none
            
        case let .selectIceOrHot(iceOrHot):
            state.iceOrHot = iceOrHot
            return .none
            
        case let .selectPrice(price):
            state.price = price
            return .none
            
        case let .selectRecommendation(isRecommend):
            state.isRecommend = isRecommend
            return .none
            
        case let .selectPhoto(photo):
            state.photo = photo
            return .none
            
        case let .editText(text):
            state.text = text
            return .none
        }
    }
}
