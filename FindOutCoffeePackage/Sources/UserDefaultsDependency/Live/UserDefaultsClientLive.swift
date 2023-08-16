//
//  UserDefaultsClientLive.swift
//  
//
//  Created by 10004 on 2023/08/16.
//

import Foundation

import Dependencies

extension UserDefaultsClient: DependencyKey {
    public static let liveValue: Self = {
        let defaults = { UserDefaults(suiteName: "group.findOutCoffee")! }
        
        return Self(
            boolForKey: { defaults().bool(forKey: $0) },
            remove: { defaults().removeObject(forKey: $0) },
            setBool: { defaults().set($0, forKey: $1) }
        )
    }()
}

