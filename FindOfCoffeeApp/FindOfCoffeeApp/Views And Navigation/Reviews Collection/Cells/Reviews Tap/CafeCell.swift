//
//  CafeCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import UIKit

class CafeCell: UICollectionViewCell {
    static let reuseIdentifier = "CafeCell"
    
    var cafe: Cafe! {
        didSet {
            titleLabel.text = cafe.title
            subtitleLabel.text = cafe.subtitle
            imageView.image = UIImage(named: cafe.thumbnail)
        }
    }

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {

        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2

        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        
        let separator = UIView()
        separator.backgroundColor = .systemGray4

        let textStack = UIStackView(arrangedSubviews: [emptyView, titleLabel, subtitleLabel])
        textStack.spacing = 2
        textStack.axis = .vertical
        
        let cellStack = UIStackView(arrangedSubviews: [textStack, separator])
        cellStack.spacing = 20
        cellStack.axis = .vertical

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        let horizontalStack = UIStackView(arrangedSubviews: [imageView, cellStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 10

        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        let imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 60)
        imageWidthConstraint.priority = .required

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.4),
            emptyView.heightAnchor.constraint(equalToConstant: 10),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -8),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

