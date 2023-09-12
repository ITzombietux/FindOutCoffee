//
//  CafeReviewMapper.swift
//  FindOfCoffeeApp
//
//  Created by 김혜지 on 2023/09/11.
//

import ReviewDetailFeature

struct CafeReviewMapper {
    static func map(cafeReview: CafeReview) -> ReviewDetail.Review {
        ReviewDetail.Review(type: "CafeReview",
                            menuId: cafeReview.menuIdentifier,
                            coffeeName: cafeReview.title,
                            imageURLs: cafeReview.thumbnail,
                            tags: [cafeReview.feeling],
                            category: cafeReview.category,
                            isRecommend: cafeReview.isRecommend,
                            text: cafeReview.text,
                            writer: cafeReview.nickname,
                            date: cafeReview.date,
                            countOfLike: cafeReview.countOfLike,
                            peopleWhoLiked: cafeReview.peopleWhoLiked)
    }
}

struct ConvenienceStoreReviewMapper {
    static func map(_ review: ConvenienceStore) -> ReviewDetail.Review {
        ReviewDetail.Review(type: "CSReview",
                            menuId: review.menuIdentifier,
                            coffeeName: review.title,
                            imageURLs: review.thumbnail,
                            tags: [review.feeling],
                            category: review.category,
                            isRecommend: review.isRecommend,
                            text: review.text,
                            writer: review.nickname,
                            date: review.date,
                            countOfLike: review.countOfLike,
                            peopleWhoLiked: review.peopleWhoLiked)
    }
}
