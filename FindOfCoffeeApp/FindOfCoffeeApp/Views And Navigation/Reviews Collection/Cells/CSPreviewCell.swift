//
//  CSPreviewCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/17.
//

import UIKit

class CSPreviewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CSPreviewCell"
    
    let previewLabel = UILabel(text: "후기 사진", font: .boldSystemFont(ofSize:22))
    let horizontalController = PreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        
        addSubview(previewLabel)
        addSubview(horizontalController.view)
        
        previewLabel.textColor = .systemBlue
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
