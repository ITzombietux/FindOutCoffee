//
//  LoginViewController.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import UIKit
import SwiftUI

public class LoginViewController: UIHostingController<LoginView> {
    public override init(rootView: LoginView) {
        super.init(rootView: rootView)
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
