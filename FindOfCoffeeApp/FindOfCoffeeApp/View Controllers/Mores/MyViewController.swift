//
//  MyViewController.swift
//  FindOfCoffeeApp
//
//  Created by 10004 on 2023/08/21.
//

import UIKit
import SwiftUI

import MyFeature

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "마이"
    }
    
    @IBSegueAction func embededMyView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: MyView())
    }
}
