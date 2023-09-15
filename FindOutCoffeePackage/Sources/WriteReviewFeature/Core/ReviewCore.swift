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
        public var content: ReviewContent.State
        
        public init(steps: [Step] = Step.cafeSteps, currentStep: Int = 0, nextButtonIsEnabled: Bool = false, content: ReviewContent.State = ReviewContent.State()) {
            self.steps = steps
            self.currentStep = currentStep
            self.nextButtonIsEnabled = nextButtonIsEnabled
            self.isLoading = false
            self.showOnBoardingView = false
            self.content = content
        }
    }
    
    public enum Action {
        case alert(PresentationAction<Alert>)
        case backButtonTapped
        case nextButtonTapped
        case submitButtonTapped
        case checkNextButtonIsEnabled
        case content(ReviewContent.Action)
        
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
                    state.nextButtonIsEnabled = state.content.store.selectedStore != nil
                case .brand:
                    state.nextButtonIsEnabled = state.content.brand?.selectedIndex != nil
                case .category:
                    state.nextButtonIsEnabled = state.content.category?.selectedIndex != nil
                case .drink:
                    state.nextButtonIsEnabled = state.content.drink?.selectedDrink != nil
                case .priceFeeling:
                    state.nextButtonIsEnabled = state.content.keyword?.selectedPriceKeywordIndex != nil && state.content.keyword?.selectedTasteKeywordIndex != nil
                case .recommendation:
                    state.nextButtonIsEnabled = state.content.recommendation?.isRecommend != nil
                case .writing:
                    state.nextButtonIsEnabled = true
                }
                return .none
                
            case .content(.completeLoading):
                state.isLoading = false
                return .none
                
            case .content(.store(.select)):
                
                return .none
                
            case .submitButtonTapped:
                state.alert = .submit()
                return .none
                
            case .alert(.presented(.confirmSubmit)):
                return .run { send in
                    await send(.content(.delegate(.saveReview)))
                }
                
            case .content:
                return .none
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
        
        Scope(state: \.content, action: /Action.content) {
            ReviewContent()
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
