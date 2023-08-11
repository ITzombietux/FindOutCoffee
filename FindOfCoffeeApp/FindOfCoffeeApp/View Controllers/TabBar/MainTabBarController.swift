//
//  MainTabBarController.swift
//  FindOfCoffeeApp
//
//  Created by 10004 on 2023/08/09.
//

import UIKit
import LoginFeature

class MainTabBarController: UITabBarController {
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loginViewController = LoginViewController(rootView: LoginView())
        
        self.addChild(loginViewController)
        self.view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        loginViewController.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
