//
//  ReviewCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

import ComposableArchitecture

struct Review: Reducer {
    enum Step: Equatable {
        case store
        case brand
        case category
        case drink
        case options
        case price
        case writing
        
        static let convenienceStoreSteps: [Self] = [.store, .drink, .options, .price, .writing]
        static let cafeSteps: [Self] = [.store, .brand, .category, .drink, .options, .price, .writing]
    }
    
    struct State: Equatable {
        var steps: [Step]
        var currentStep: Int
        var content: ReviewContent.State
        
        init(steps: [Step] = Step.cafeSteps, currentStep: Int = 0, content: ReviewContent.State = ReviewContent.State()) {
            self.steps = steps
            self.currentStep = currentStep
            self.content = content
        }
    }
    
    enum Action {
        case nextButtonTapped
        case saveReview
        case content(ReviewContent.Action)
    }
    
    init() {}
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                if state.steps[state.currentStep] != .writing {
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
