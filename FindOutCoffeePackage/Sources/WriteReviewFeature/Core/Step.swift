//
//  Step.swift
//  
//
//  Created by 김혜지 on 2023/08/19.
//

public extension Review {
    enum Step: Equatable {
        case store
        case brand
        case category
        case drink
        case onBoarding
        case priceFeeling
        case recommendation
        case writing
        
        public static let convenienceStoreSteps: [Self] = [.store, .brand, .drink, .onBoarding, .priceFeeling, .recommendation, .writing]
        public static let cafeSteps: [Self] = [.store, .brand, .category, .drink, .onBoarding, .priceFeeling, .recommendation, .writing]
    }
}
