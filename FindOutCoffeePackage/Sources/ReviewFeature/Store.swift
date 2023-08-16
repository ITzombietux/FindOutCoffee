//
//  Store.swift
//  
//
//  Created by 김혜지 on 2023/08/17.
//

extension ReviewContent {
    enum Store: Equatable, CustomStringConvertible {
        case convenienceStore
        case cafe
        
        var description: String {
            switch self {
            case .convenienceStore:
                return "편의점"
            case .cafe:
                return "카페"
            }
        }
    }
}
