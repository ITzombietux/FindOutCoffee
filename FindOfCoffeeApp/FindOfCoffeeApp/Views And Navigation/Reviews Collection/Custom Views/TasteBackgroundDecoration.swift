//
//  TasteBackgroundDecoration.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import UIKit

class TasteBackgroundDecoration: UICollectionReusableView {
    static let reuseIdentifier = "taste-background-decoration"
    
    let titleLabel = UILabel(text: "취향을 찾아서", font: .boldSystemFont(ofSize: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configure()
        isOpaque = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        
        let stack = UIStackView(arrangedSubviews: [separator, titleLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.widthAnchor.constraint(equalToConstant: 300),
        ])
//        NSLayoutConstraint.activate([
//            imageView.widthAnchor.constraint(equalToConstant: 120),
//            imageView.heightAnchor.constraint(equalToConstant: 120),
//            separator.heightAnchor.constraint(equalToConstant: 1),
//
//            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.clear(rect)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: [
            UIColor.secondarySystemBackground.cgColor,
            UIColor.clear.cgColor
        ] as CFArray, locations: nil)!

        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: bounds.minY), end: CGPoint(x: 0, y: bounds.maxY), options: [])
    }

}

