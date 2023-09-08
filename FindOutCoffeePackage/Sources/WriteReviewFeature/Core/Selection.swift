//
//  Selection.swift
//  
//
//  Created by Joy on 2023/08/23.
//

public extension ReviewContent {
    enum Selection {
        case store(Store)
        case brand(String)
        case category(String)
        case drink(String)
        case priceFeeling(String)
        case recommendation(Bool)
    }
}
