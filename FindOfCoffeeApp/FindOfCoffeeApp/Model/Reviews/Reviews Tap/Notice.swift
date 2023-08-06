//
//  Notice.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation

struct Notice: Codable, Hashable, Equatable {
    let id: String
//    let artworkUrl: URL
    let title: String
    let secondaryTitle: String
    let subtitle: String
    let thumbnail: String
    let text: String
}
