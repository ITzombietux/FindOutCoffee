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
        public var brands: [String]?
        public var categories: [String]?
        public var drinks: [String]?
        public var priceFeelings: [String]?
        public var store: Store?
        public var brand: String?
        public var category: String?
        public var drink: String?
        public var size: Size?
        public var iceOrHot: IceOrHot?
        public var priceFeeling: String?
        public var isRecommend: Bool?
        public var photo: [Data]?
        public var text: String?
        
        public init(brands: [String]? = nil, categories: [String]? = nil, drinks: [String]? = nil, priceFeelings: [String]? = nil, store: Store? = nil, brand: String? = nil, category: String? = nil, drink: String? = nil, size: Size? = nil, iceOrHot: IceOrHot? = nil, priceFeeling: String? = nil, isRecommend: Bool? = nil, photo: [Data]? = nil, text: String? = nil) {
            self.brands = brands
            self.categories = categories
            self.drinks = drinks
            self.priceFeelings = priceFeelings
            self.store = store
            self.brand = brand
            self.category = category
            self.drink = drink
            self.size = size
            self.iceOrHot = iceOrHot
            self.priceFeeling = priceFeeling
            self.isRecommend = isRecommend
            self.photo = photo
            self.text = text
        }
    }
    
    public enum Action {
        case load(Review.Step)
        case loadBrands
        case loadCategories
        case loadDrinks
        case loadPriceFeelings
        case completeLoading
        case select(Selection)
        case selectPhoto([Data])
        case editText(String)
        case loadBrandsResponse(TaskResult<CafeNamesResponse>)
        case loadCafeDrinksResponse(TaskResult<CafeMenusResponse>)
        case loadConvenienceStoreDrinksResponse(TaskResult<ConvenienceStoreMenusResponse>)
        case loadConvenienceStoreBrandsResponse(TaskResult<ConvenienceStoreBrandsResponse>)
        case loadCategoriesResponse(TaskResult<CafeCategoresResponse>)
        case saveReviewResponse(TaskResult<SubmitReviewResponse>)
        case uploadImagesResponse(TaskResult<SubmitImagesResponse>)
        case dismiss
        case delegate(Delegate)
        
        public enum Delegate {
            case saveReview
        }
    }
    
    @Dependency(\.reviewClient) var reviewClient
    @Dependency(\.date.now) var now
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .load(step):
            switch step {
            case .brand:
                return .send(.loadBrands)
            case .category:
                return .send(.loadCategories)
            case .drink:
                return .send(.loadDrinks)
            case .price:
                return .send(.loadPriceFeelings)
            default:
                return .send(.completeLoading)
            }
            
        case .loadBrands:
            guard let store = state.store else { return .none }
            switch store {
            case .cafe:
                return .run { send in
                    await send(
                        .loadBrandsResponse(
                            await TaskResult {
                                try await self.reviewClient.cafeNames()
                            }
                        )
                    )
                }
            case .convenienceStore:
                return .run { send in
                    await send(
                        .loadConvenienceStoreBrandsResponse(
                            await TaskResult {
                                try await self.reviewClient.convenienceStoreBrands()
                            }
                        )
                    )
                }
            }
            
        case .loadBrandsResponse(.success(let response)):
            state.brands = response.names
            return .send(.completeLoading)
            
        case .loadBrandsResponse(.failure(let error)):
            return .none
            
        case .loadCategories:
            guard let brand = state.brand else { return .none }
            
            return .run { send in
                await send(
                    .loadCategoriesResponse(
                        await TaskResult {
                            try await self.reviewClient.cafeCategores(brand)
                        }
                    )
                )
            }
            
        case .loadCategoriesResponse(.success(let response)):
            state.categories = response.names
            return .send(.completeLoading)
            
        case .loadCategoriesResponse(.failure(let error)):
            return .none
            
        case .loadDrinks:
            guard let store = state.store else { return .none }
            switch store {
            case .cafe:
                guard let brand = state.brand else { return .none }
                guard let category = state.category else { return .none }
                return .run { send in
                    await send(
                        .loadCafeDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.cafeMenus(brand, category)
                            }
                        )
                    )
                }
            case .convenienceStore:
                guard let brand = state.brand else { return .none }
                return .run { send in
                    await send(
                        .loadConvenienceStoreDrinksResponse(
                            await TaskResult {
                                try await self.reviewClient.convenienceStoreMenus(brand)
                            }
                        )
                    )
                }
            }
            
        case .loadCafeDrinksResponse(.success(let response)):
            state.drinks = response.names
            return .send(.completeLoading)
            
        case .loadCafeDrinksResponse(.failure(let error)):
            return .none
            
        case .loadConvenienceStoreBrandsResponse(.success(let response)):
            state.brands = response.names
            return .send(.completeLoading)
            
        case .loadConvenienceStoreBrandsResponse(.failure(let error)):
            return .none
            
        case .loadConvenienceStoreDrinksResponse(.success(let response)):
            state.drinks = response.names
            return .send(.completeLoading)
            
        case .loadConvenienceStoreDrinksResponse(.failure(let error)):
            return .none
            
        case .loadPriceFeelings:
            state.priceFeelings = ["너무 비싸요😂", "비싸지만 맛있어요🫢", "가성비가 좋아요👍"]
            return .send(.completeLoading)
            
        case .completeLoading:
            return .none
            
        case let .select(selection):
            switch selection {
            case let .store(store):
                state.store = store
                if store == .convenienceStore {
                    state.brand = nil
                    state.categories = nil
                }
            case let .brand(brand):
                state.brand = brand
            case let .category(category):
                state.category = category
            case let .drink(drink):
                state.drink = drink
            case let .size(size):
                state.size = size
            case let .iceOrHot(iceOrHot):
                state.iceOrHot = iceOrHot
            case let .priceFeeling(priceFeeling):
                state.priceFeeling = priceFeeling
            case let .recommendation(isRecommend):
                state.isRecommend = isRecommend
            }
            return .none
            
        case let .selectPhoto(photo):
            state.photo = photo
            return .none
            
        case let .editText(text):
            state.text = text
            return .none
            
        case .delegate(.saveReview):
            guard let store = state.store else { return .none }
            guard let userIdentifier = UserDefaults.standard.string(forKey: "isLoggedInKey") else { return .none }
            guard let nickname = UserDefaults.standard.string(forKey: "nameKey") else { return .none }
            guard let title = state.drink else { return .none }
            guard let size = state.size else { return .none }
            guard let iceOrHot = state.iceOrHot else { return .none }
            guard let brand = state.brand else { return .none }
            guard let feeling = state.priceFeeling else { return .none }
            guard let isRecommend = state.isRecommend else { return .none }
            let category = state.category ?? ""
            let text = state.text ?? ""
            
            return .run { send in
                await send(
                    .saveReviewResponse(
                        await TaskResult {
                            try await self.reviewClient.submit(
                                SubmitReviewRequest(
                                    coffee: Coffee(userIdentifier: userIdentifier,
                                                   nickname: nickname,
                                                   title: title,
                                                   size: size.rawValue,
                                                   isHot: iceOrHot.rawValue,
                                                   text: text,
                                                   address: brand,
                                                   category: category,
                                                   date:  self.now.formatted(to: "yyyy-MM-dd"),
                                                   feeling: feeling,
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
            let photoDatas = state.photo ?? []
            let isExistPhoto = !photoDatas.isEmpty
            guard let store = state.store else { return .none }
            
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
