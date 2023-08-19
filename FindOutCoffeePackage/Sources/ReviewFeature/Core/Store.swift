//
//  Store.swift
//  
//
//  Created by 김혜지 on 2023/08/17.
//

public extension ReviewContent {
    enum Store: Equatable, CustomStringConvertible {
        case convenienceStore
        case cafe
        
        public var description: String {
            switch self {
            case .convenienceStore:
                return "편의점"
            case .cafe:
                return "카페"
            }
        }
    }
}
