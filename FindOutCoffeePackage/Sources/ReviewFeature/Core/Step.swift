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
        case options
        case price
        case writing
        
        public static let convenienceStoreSteps: [Self] = [.store, .drink, .options, .price, .writing]
        public static let cafeSteps: [Self] = [.store, .brand, .category, .drink, .options, .price, .writing]
    }
}
