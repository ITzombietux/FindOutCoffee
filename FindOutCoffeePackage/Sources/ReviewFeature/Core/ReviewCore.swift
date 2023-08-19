//
//  ReviewCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

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
        case nextButtonTapped
        case saveReview
        case content(ReviewContent.Action)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                if state.steps[state.currentStep] == .writing {
                    // TODO: saveReview
                    return .none
                }
                
                state.currentStep += 1
                return .none
                
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
                
            case .content:
                return .none
            }
        }
        
        Scope(state: \.content, action: /Action.content) {
            ReviewContent()
        }
    }
}
