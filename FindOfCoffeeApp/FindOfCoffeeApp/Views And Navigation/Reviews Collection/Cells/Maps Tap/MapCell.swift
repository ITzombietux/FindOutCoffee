//
//  MapCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/21.
//

import UIKit

class MapCell: UICollectionViewCell {
    static let reuseIdentifier = "MapCell"
    
    let titleLabel = UILabel(text: "카페 이름", font: UIFont.preferredFont(forTextStyle: .headline), numberOfLines: 3)
    let addressLabel = UILabel(text: "카페 주소", font: UIFont.preferredFont(forTextStyle: .subheadline), numberOfLines: 2)
    let subtitleLabel = UILabel(text: "짧은 카페 소개", font: UIFont.boldSystemFont(ofSize: 14), numberOfLines: 3)
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 12
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        
        titleLabel.textColor = .label
        addressLabel.textColor = .secondaryLabel
        subtitleLabel.textColor = .systemBlue
        
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
    
        let textStack = UIStackView(arrangedSubviews: [emptyView, addressLabel, titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        let horizontalStack = UIStackView(arrangedSubviews: [imageView, textStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .top
        horizontalStack.spacing = 16
        
        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        let imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 100)
        imageWidthConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            emptyView.heightAnchor.constraint(equalToConstant: 10),
            emptyView.widthAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  12),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
