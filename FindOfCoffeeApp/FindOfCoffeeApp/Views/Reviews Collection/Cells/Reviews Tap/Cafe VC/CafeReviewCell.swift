//
//  CafeReviewCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import UIKit

class CafeReviewCell: UICollectionViewCell {
    static let reuseIdentifier = "CafeReviewCell"

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let nameLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        nameLabel.textColor = UIColor(named: "mainColor")
        
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        
        let separator = UIView()
        separator.backgroundColor = .systemGray4
        
        let textStack = UIStackView(arrangedSubviews: [emptyView, titleLabel, subtitleLabel, nameLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let cellStack = UIStackView(arrangedSubviews: [textStack, separator])
        cellStack.axis = .vertical
        cellStack.spacing = 20
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "noimage")
        
        let horizontalStack = UIStackView(arrangedSubviews: [imageView, cellStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 10
        
        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.heightAnchor.constraint(equalToConstant: 4),
            separator.heightAnchor.constraint(equalToConstant: 0.4),
            separator.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.95),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horizontalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

