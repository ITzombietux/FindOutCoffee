//
//  ReviewContentCore.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

import Foundation

public struct ReviewContent: Reducer {
    public struct State: Equatable {
        public var store: StoreSelection.State?
        public var brand: BrandSelection.State?
        public var category: CategorySelection.State?
        public var drink: DrinkSelection.State?
        public var keyword: KeywordSelection.State?
        public var recommendation: RecommendationSelection.State?
        public var writing: Writing.State?
        
        public init(store: StoreSelection.State? = nil, brand: BrandSelection.State? = nil, category: CategorySelection.State? = nil, drink: DrinkSelection.State? = nil, keyword: KeywordSelection.State? = nil, recommendation: RecommendationSelection.State? = nil, writing: Writing.State? = nil) {
            self.store = store
            self.brand = brand
            self.category = category
            self.drink = drink
            self.keyword = keyword
            self.recommendation = recommendation
            self.writing = writing
        }
    }
    
    public enum Action {
        case load(Review.Step)
        case loadDrinks
        case loadPriceFeelings
        case completeLoading
        case selectPhoto([Data])
        case editText(String)
        case loadCafeDrinksResponse(TaskResult<CafeMenusResponse>)
        case loadConvenienceStoreDrinksResponse(TaskResult<ConvenienceStoreMenusResponse>)
        case loadConvenienceStoreBrandsResponse(TaskResult<ConvenienceStoreBrandsResponse>)
        case saveReviewResponse(TaskResult<SubmitReviewResponse>)
        case uploadImagesResponse(TaskResult<SubmitImagesResponse>)
        case dismiss
        case delegate(Delegate)
//        case store(StoreSelection.Action)
//        case brand(BrandSelection.Action)
//        case category(CategorySelection.Action)
//        case drink(DrinkSelection.Action)
//        case priceFeeling(KeywordSelection.Action)
//        case recommendation(RecommendationSelection.Action)
//        case writing(Writing.Action)
        
        public enum Delegate {
            case saveReview
        }
    }
    
    @Dependency(\.reviewClient) var reviewClient
    @Dependency(\.date.now) var now
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .completeLoading:
            return .none
            
        case .delegate(.saveReview):
            guard let store = state.store?.selectedStore else { return .none }
            guard let userIdentifier = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return .none }
            guard let nickname = UserDefaults.standard.string(forKey: "nameKey") else { return .none }
            guard let title = state.drink?.selectedDrink else { return .none }
            guard let brand = state.brand?.selectedBrand else { return .none }
            guard let keywords = state.keyword?.selectedKeywords else { return .none }
            guard let isRecommend = state.recommendation?.isRecommend else { return .none }
            let category = state.category?.selectedCategory ?? ""
            let text = state.writing?.text ?? ""
            
            return .run { send in
                await send(
                    .saveReviewResponse(
                        await TaskResult {
                            try await self.reviewClient.submit(
                                SubmitReviewRequest(
                                    coffee: Coffee(userIdentifier: userIdentifier,
                                                   nickname: nickname,
                                                   title: title,
                                                   text: text,
                                                   address: brand,
                                                   category: category,
                                                   date:  self.now.formatted(to: "yyyy-MM-dd"),
                                                   feeling: keywords.joined(separator: ","),
                                                   isRecommend: isRecommend,
                                                   isPublic: false
                                                  ),
                                    selectedTitle: store == .cafe ? "CafeReview" : "CSReview"
                                )
                            )
                        }
                    )
                )
            }
        
        case let .saveReviewResponse(.success(response)):
            let photoDatas = state.writing?.photo ?? []
            let isExistPhoto = !photoDatas.isEmpty
            guard let store = state.store?.selectedStore else { return .none }
            
            guard isExistPhoto else {
                return .run { send in
                    await send(.dismiss)
                }
            }
            
            return .run { send in
                await send(
                    .uploadImagesResponse(
                        await TaskResult {
                            try await self.reviewClient.uploadImages(
                                SubmitImagesRequest(menuIdentifier: response.menuIdentifier,
                                                    userIdentifier: response.userIdentifier,
                                                    selectedTitle: store == .cafe ? "CafeReview" : "CSReview",
                                                    photosData: photoDatas)
                            )
                        }
                    )
                )
            }
            
        case let .saveReviewResponse(.failure(error)):
            return .none
            
        case let .uploadImagesResponse(.success(response)):
            return .run { send in
                await send(.dismiss)
            }
            
        case let .uploadImagesResponse(.failure(error)):
            return .none
            
        case .dismiss:
            NotificationCenter.default.post(name: Notification.Name.dismissReviewView, object: nil)
            return .none
            
        case .delegate:
            return .none
            
//        case let .store(.select(selectedStore)):
//
//            return .none
//
//        case let .brand(.):
        }
    }
}

extension Date {
    func formatted(to: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = to
        return dateFormatter.string(from: self)
    }
}
