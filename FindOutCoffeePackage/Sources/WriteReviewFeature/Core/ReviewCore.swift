//
//  ReviewCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

import Foundation

import ComposableArchitecture

public struct Review: Reducer {
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        public var steps: [Step]
        public var currentStep: Int
        public var nextButtonIsEnabled: Bool
        public var isLoading: Bool
        public var showOnBoardingView: Bool
//        public var content: ReviewContent.State
        public var store: StoreSelection.State
        public var brand: BrandSelection.State?
        public var category: CategorySelection.State?
        public var drink: DrinkSelection.State?
        public var keyword: KeywordSelection.State?
        public var recommendation: RecommendationSelection.State?
        public var writing: Writing.State?
        
        public init(steps: [Step] = Step.cafeSteps, currentStep: Int = 0, nextButtonIsEnabled: Bool = false) {
            self.steps = steps
            self.currentStep = currentStep
            self.nextButtonIsEnabled = nextButtonIsEnabled
            self.isLoading = false
            self.showOnBoardingView = false
        }
    }
    
    public enum Action {
        case alert(PresentationAction<Alert>)
        case backButtonTapped
        case nextButtonTapped
        case submitButtonTapped
        case checkNextButtonIsEnabled
//        case content(ReviewContent.Action)
        public var store(StoreSelection.Action)
        public var brand(BrandSelection.Action)
        public var category(CategorySelection.Action)
        public var drink(DrinkSelection.Action)
        public var keyword(KeywordSelection.Action)
        public var recommendation(RecommendationSelection.Action)
        public var writing(Writing.Action)
        
        public enum Alert {
            case confirmSubmit
        }
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                if state.currentStep == 0 {
                    NotificationCenter.default.post(name: Notification.Name.dismissReviewView, object: nil)
                    return .none
                }
                
                state.currentStep -= 1
                return .send(.checkNextButtonIsEnabled)
                
            case .nextButtonTapped:
                if state.showOnBoardingView {
                    state.showOnBoardingView = false
                    return .run { send in
                        await send(.checkNextButtonIsEnabled)
                    }
                }
                
                if state.steps[state.currentStep] == .writing {
                    return .run { send in
                        await send(.submitButtonTapped)
                    }
                }
                
                state.currentStep += 1
                state.isLoading = true
                
                return .run { send in
                    await send(.checkNextButtonIsEnabled)
                }
                
            case .checkNextButtonIsEnabled:
                if state.showOnBoardingView {
                    state.nextButtonIsEnabled = true
                    return .none
                }
                
                switch state.steps[state.currentStep] {
                case .store:
                    state.nextButtonIsEnabled = state.store.selectedStore != nil
                case .brand:
                    state.nextButtonIsEnabled = state.brand?.selectedIndex != nil
                case .category:
                    state.nextButtonIsEnabled = state.category?.selectedIndex != nil
                case .drink:
                    state.nextButtonIsEnabled = state.drink?.selectedDrink != nil
                case .priceFeeling:
                    state.nextButtonIsEnabled = state.keyword?.selectedPriceKeywordIndex != nil && state.keyword?.selectedTasteKeywordIndex != nil
                case .recommendation:
                    state.nextButtonIsEnabled = state.recommendation?.isRecommend != nil
                case .writing:
                    state.nextButtonIsEnabled = true
                }
                return .none
                
            case .submitButtonTapped:
                state.alert = .submit()
                return .none
                
            case .alert(.presented(.confirmSubmit)):
                return .run { send in
                    await send(.content(.delegate(.saveReview)))
                }
                
            case .alert:
                return .none
                
            case .store(.select):
                state.nextButtonIsEnabled = state.store.selectedStore != nil
                return .none
                
            case .store:
                return .none
                
            case .brand:
                return .none
                
            case .category:
                return .none
                
            case .drink:
                return .none
                
            case .keyword:
                return .none
                
            case .recommendation:
                return .none
                
            case .writing:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
        .ifLet(\.brand, action: /Action.brand) {
            BrandSelection()
        }
        .ifLet(\.category, action: /Action.category) {
            CategorySelection()
        }
        .ifLet(\.drink, action: /Action.drink) {
            DrinkSelection()
        }
        .ifLet(\.keyword, action: /Action.keyword) {
            KeywordSelection()
        }
        .ifLet(\.recommendation, action: /Action.recommendation) {
            RecommendationSelection()
        }
        .ifLet(\.writing, action: /Action.writing) {
            Writing()
        }
        
        Scope(state: \.store, action: /Action.store) {
            StoreSelection()
        }
    }
}

extension AlertState where Action == Review.Action.Alert {
    static func submit() -> Self {
        Self {
            TextState("리뷰를 등록하시겠습니까?")
        } actions: {
            ButtonState(role: .destructive) {
                TextState("취소")
            }
            
            ButtonState(role: .cancel, action: .confirmSubmit) {
                TextState("등록하기")
            }
        } message: {
            TextState(
              """
              1일 내에 관리자 검수를 거쳐\n정상적으로 리뷰가 등록됩니다!!!
              """
            )
        }
    }
}
