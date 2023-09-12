//
//  CafeReviewMapper.swift
//  FindOfCoffeeApp
//
//  Created by 김혜지 on 2023/09/11.
//

import ReviewDetailFeature

struct CafeReviewMapper {
    static func map(cafeReview: CafeReview) -> ReviewDetail.Review {
        ReviewDetail.Review(coffeeName: cafeReview.title, imageURLs: cafeReview.thumbnail, tags: [cafeReview.feeling], category: cafeReview.category, isRecommend: cafeReview.isRecommend, text: cafeReview.text, writer: cafeReview.nickname, date: cafeReview.date, countOfLike: cafeReview.countOfLike, peopleWhoLiked: cafeReview.peopleWhoLiked)
    }
}
