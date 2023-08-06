//
//  WriteReviewsViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/30.
//

import UIKit

class WriteReviewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: false) {
            
        }
    }
}
