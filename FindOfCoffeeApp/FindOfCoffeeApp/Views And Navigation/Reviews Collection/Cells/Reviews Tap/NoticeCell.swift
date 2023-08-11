//
//  NoticeCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//
import UIKit

class NoticeCell: UICollectionViewCell {
    static let reuseIdentifier = "NoticeCell"

    var notice: Notice! {
        didSet {
            titleLabel.text = notice.title
            secondaryTitleLabel.text = notice.secondaryTitle
            subtitleLabel.text = notice.subtitle
            imageView.image = UIImage(named: notice.thumbnail)
            imageView.backgroundColor = .tertiarySystemBackground
        }
    }
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let secondaryTitleLabel = UILabel()
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
        
        secondaryTitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        secondaryTitleLabel.textColor = .systemBlue
        secondaryTitleLabel.numberOfLines = 1
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.borderWidth = 0.4
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    
        let spacer = UIView()
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        
        let stack = UIStackView(arrangedSubviews: [secondaryTitleLabel, titleLabel, subtitleLabel, imageView])
        stack.axis = .vertical
        stack.spacing = 6
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -8),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
        stack.setCustomSpacing(10, after: separator)
        stack.setCustomSpacing(10, after: subtitleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
