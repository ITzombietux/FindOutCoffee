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
        public var photo: [Data]?
        public var text: String
        public var text: String?
        
        public init(brands: [String]? = nil, categories: [String]? = nil, drinks: [String]? = nil, prices: [String]? = nil, store: Store? = nil, brand: String? = nil, category: String? = nil, drink: String? = nil, iceOrHot: IceOrHot? = nil, price: String? = nil, photo: [Data]? = nil, text: String = "") {
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
        case selectPhoto([Data])
        case editText(String)
        case loadBrandsResponse(TaskResult<CafeNamesResponse>)
        case loadDrinksResponse(TaskResult<CafeMenusReponse>)
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
            state.categories = ["에스프레소", "콜드브루", "티바나", "요거트", "주스&에이드", "기타"]
            return .send(.completeLoading)
            
        case .loadDrinks:
            guard let brand = state.brand else { return .none }
            return .run { send in
                await send(
                    .loadDrinksResponse(
                        await TaskResult {
                            try await self.reviewClient.cafeMenus(brand)
                        }
                    )
                )
            }
            
        case .loadDrinksResponse(.success(let response)):
            state.drinks = response.names
            return .none
            
        case .loadDrinksResponse(.failure(let error)):
            return .none
            
        case .loadPrices:
            state.prices = ["너무 비싸요", "비싸지만 맛있어요"]
            return .none
            
        case .completeLoading:
            return .none
            
        case let .selectStore(store):
            state.store = store
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
            
        case let .selectPhoto(photo):
            state.photo = photo
            return .none
            
        case let .editText(text):
            state.text = text
            return .none
        }
    }
}
