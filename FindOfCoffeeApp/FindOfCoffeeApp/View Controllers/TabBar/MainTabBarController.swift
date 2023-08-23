//
//  MainTabBarController.swift
//  FindOfCoffeeApp
//
//  Created by 10004 on 2023/08/17.
//

import UIKit
import LoginFeature
import UserDefaultsDependency

class MainTabBarController: UITabBarController {
    private var loginViewController = LoginViewController(rootView: LoginView())
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNotification()
        let isLoggedInKey = UserDefaults.standard.string(forKey: isLoggedInKey) ?? ""
        guard isLoggedInKey.count == 0 else { return }
        configureLoginView()
    }
    
    private func configureLoginView() {
        self.addChild(loginViewController)
        self.view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        loginViewController.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showingLoginView), name: Notification.Name.showingLoginView, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissLoginView), name: Notification.Name.dismissLoginView, object: nil)
    }
    
    private func removeDismissNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.dismissLoginView, object: nil)
    }
    
    private func removeShowingNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.showingLoginView, object: nil)
    }
    
    @objc func dismissLoginView() {
        loginViewController.willMove(toParent: nil)
        loginViewController.view.removeFromSuperview()
        loginViewController.removeFromParent()
        removeDismissNotification()
    }
    
    @objc func showingLoginView() {
        configureLoginView()
        removeShowingNotification()
    }
}
