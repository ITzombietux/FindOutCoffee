//
//  ScreenshotCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/26.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    static let reuseIdentifier = "ScreenshotCell"
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .systemGray6
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError()
    }
}
