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
        public var steps: [Step]
        public var currentStep: Int
        public var content: ReviewContent.State
        
        public init(steps: [Step] = Step.cafeSteps, currentStep: Int = 0, content: ReviewContent.State = ReviewContent.State()) {
            self.steps = steps
            self.currentStep = currentStep
            self.content = content
        }
    }
    
    public enum Action {
        case backButtonTapped
        case nextButtonTapped
        case saveReview
        case content(ReviewContent.Action)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                if state.currentStep > 0 {
                    state.currentStep -= 1
                    return .none
                }
                
                NotificationCenter.default.post(name: Notification.Name.dismissReviewView, object: nil)
                return .none
                
            case .nextButtonTapped:
                switch state.steps[state.currentStep] {
                case .store:
                    guard state.content.store != nil else { return .none }
                case .brand:
                    guard state.content.brand != nil else { return .none }
                case .category:
                    guard state.content.category != nil else { return .none }
                case .drink:
                    guard state.content.drink != nil else { return .none }
                case .options:
                    guard state.content.size != nil,
                          state.content.iceOrHot != nil
                    else { return .none }
                case .price:
                    guard state.content.isRecommend != nil,
                          state.content.priceFeeling != nil
                    else { return .none }
                case .writing:
                    break
                }
                return .send(.content(.load(state.steps[state.currentStep + 1])))
                
            case .saveReview:
                // TODO: 서버 통신
                return .none
                
            case let .content(.selectStore(store)):
                switch store {
                case .convenienceStore:
                    state.steps = Step.convenienceStoreSteps
                    
                case .cafe:
                    state.steps = Step.cafeSteps
                }
                return .none
                
            case .content(.completeLoading):
                state.currentStep += 1
                return .none
                
            case .content:
                return .none
            }
        }
        
        Scope(state: \.content, action: /Action.content) {
            ReviewContent()
        }
    }
}
