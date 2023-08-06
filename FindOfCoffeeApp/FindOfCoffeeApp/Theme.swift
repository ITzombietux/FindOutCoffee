//
//  Theme.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/09.
//

import UIKit

struct Theme {
    static func apply(to window: UIWindow) {
        let tabBar = UITabBar.appearance()
        tabBar.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
    }
}
