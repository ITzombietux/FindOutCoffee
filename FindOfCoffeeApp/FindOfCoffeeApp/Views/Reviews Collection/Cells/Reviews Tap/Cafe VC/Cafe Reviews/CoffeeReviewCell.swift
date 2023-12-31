//
//  CoffeeReviewCell.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/26.
//

import UIKit

class CoffeeReviewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CoffeeReviewCell"
    
    var cafeReviewDetail: CafeReview! {
        didSet {
            titleLabel.text = cafeReviewDetail.title
            subtitleLabel.text = "#\(cafeReviewDetail?.category ?? "")#\(cafeReviewDetail?.size ?? "")#\(cafeReviewDetail?.feeling ?? "")#\(cafeReviewDetail?.isHot ?? "")"
            nameLabel.text = "작성자: \(cafeReviewDetail?.nickname ?? "")"
            let thumbnail = cafeReviewDetail.thumbnail.first ?? ""
            if thumbnail.isEmpty {
                thumbnailImageView.image = UIImage(named: "noimage")
            } else {
                let url = URL(string: thumbnail)
                thumbnailImageView.kf.setImage(with: url)
            }
            dateLabel.text = "작성일: \(cafeReviewDetail?.date ?? "")"
            textLabel.text = cafeReviewDetail?.text
        }
    }
    
    let thumbnailImageView = UIImageView(cornerRadius: 28)
    let titleLabel = UILabel(text: "커피 이름", font: .boldSystemFont(ofSize: 22), numberOfLines: 2)
    let subtitleLabel = UILabel(text: "설명", font: .systemFont(ofSize: 18), numberOfLines: 2)
    let nameLabel = UILabel(text: "닉네임", font: .systemFont(ofSize: 18), numberOfLines: 2)
    let dateLabel = UILabel(text: "날짜", font: .boldSystemFont(ofSize: 20))
    let textLabel = UILabel(text: "커피에 대한 설명", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        thumbnailImageView.constrainWidth(constant: 114)
        thumbnailImageView.constrainHeight(constant: 114)
        
        subtitleLabel.textColor = .systemGray
        nameLabel.textColor = UIColor(named: "mainColor")
        
        let subHorizontalStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        subHorizontalStackView.axis = .vertical
        subHorizontalStackView.spacing = 2
        
        let mainHorizontalStackView = UIStackView(arrangedSubviews: [
            thumbnailImageView,
            VerticalStackView(arrangedSubviews: [
                subHorizontalStackView, nameLabel
            ],spacing: 38)
        ])
        mainHorizontalStackView.spacing = 16
        mainHorizontalStackView.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [
            mainHorizontalStackView,
            dateLabel,
            textLabel
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        NSLayoutConstraint.activate([
            subHorizontalStackView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: mainHorizontalStackView.bottomAnchor, constant: 2)
        ])
    }
}


