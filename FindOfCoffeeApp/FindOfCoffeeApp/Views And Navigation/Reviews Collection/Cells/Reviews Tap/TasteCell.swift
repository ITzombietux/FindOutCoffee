//
//  TasteCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import UIKit

class TasteCell: UICollectionViewCell {
    static let reuseIdentifier = "TasteCell"
    
    var taste: Taste! {
        didSet {
            titleLabel.text = taste.title
            subtitleLabel.text = taste.subtitle
            imageView.image = UIImage(named: taste.thumbnail)
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
        backgroundView = UIView()
        backgroundView?.backgroundColor = .tertiarySystemBackground
        backgroundView?.layer.cornerRadius = 8
        backgroundView?.layer.masksToBounds = true
        
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 3
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        
        let spacerView = UIView()
        
        let stack = UIStackView(arrangedSubviews: [
            separator, titleLabel, subtitleLabel, spacerView, imageView
        ])
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        stack.setCustomSpacing(10, after: separator)
        stack.setCustomSpacing(10, after: subtitleLabel)
    }
}
