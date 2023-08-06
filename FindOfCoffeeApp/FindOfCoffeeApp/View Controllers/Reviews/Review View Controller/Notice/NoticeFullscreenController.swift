//
//  NoticeFullscreenController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import UIKit

class NoticeFullscreenController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var noticeLabel: UILabel! {
        didSet {
            noticeLabel.numberOfLines = 0
            noticeLabel.sizeToFit()
        }
    }
    
    var header: UIImage?
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageView.image = header
        noticeLabel.text = text
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
