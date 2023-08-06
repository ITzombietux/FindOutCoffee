//
//  Taste.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation

struct Taste: Codable, Hashable, Equatable {
    let id: String
//    let artworkUrl: URL
    let title: String
    let subtitle: String
    let thumbnail: String
}
