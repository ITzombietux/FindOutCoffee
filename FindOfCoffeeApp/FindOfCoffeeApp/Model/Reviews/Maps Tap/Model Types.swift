//
//  Cafe.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/19.
//
import Foundation

extension NetworkManager {
    struct MapResult: Decodable, Hashable, Equatable {
        static func == (lhs: NetworkManager.MapResult, rhs: NetworkManager.MapResult) -> Bool {
            return true
        }
        
        let documents: [Map]
        let meta: MetaData
    }
    
    struct Map: Decodable, Hashable, Equatable {
        let id: String
        let placeName: String
        let roadAddressName: String
        let x: String
        let y: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case placeName = "place_name"
            case roadAddressName = "road_address_name"
            case x
            case y
        }
    }

    struct MetaData: Decodable, Hashable, Equatable {
        let isEnd: Bool
        let pageableCount: Int
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
}
