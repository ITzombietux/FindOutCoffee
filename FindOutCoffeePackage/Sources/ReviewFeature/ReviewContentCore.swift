//
//  ReviewContentCore.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

struct ReviewContent: Reducer {
    struct State: Equatable {
        var brands: [String]?
        var categories: [String]?
        var drinks: [String]?
        var prices: [String]?
        var store: Store?
        var brand: String?
        var category: String?
        var drink: String?
        var iceOrHot: IceOrHot?
        var price: String?
        
        init(store: Store? = nil) {
            self.store = store
        }
    }
    
    enum Action {
        case loadBrands
        case loadCategories
        case loadDrinks
        case loadPrices
        case selectStore(Store)
        case selectBrand(String)
        case selectCategory(String)
        case selectDrink(String)
        case selectIceOrHot(IceOrHot)
        case selectPrice(String)
    }
    
    init() {}
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadBrands:
            state.brands = ["스타벅스", "투썸플레이스", "이디야", "할리스"]
            return .none
            
        case .loadCategories:
            state.categories = ["에스프레소", "콜드브루", "티바나", "요거트", "주스&에이드", "기타"]
            return .none
            
        case .loadDrinks:
            state.drinks = ["아메리카노", "카페라떼", "바닐라라떼", "헤이즐넛라떼"]
            return .none
            
        case .loadPrices:
            state.prices = ["너무 비싸요", "비싸지만 맛있어요"]
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
        }
    }
}
