//
//  ReviewCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

import ComposableArchitecture

struct Review: Reducer {
    enum Step: Int, Equatable {
        case store = 1
        case brand = 2
        case category = 3
        case drink = 4
        case options = 5
        case price = 6
        case writing = 7
    }
    
    struct State: Equatable {
        var step: Step
        var content: ReviewContent.State
        
        init(step: Step = .store, content: ReviewContent.State = ReviewContent.State()) {
            self.step = step
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
                guard state.step != .writing else { return .none }
                guard let nextStep = Step(rawValue: state.step.rawValue + 1) else { return .none }
                state.step = nextStep
                return .none
                
            case .saveReview:
                // TODO: 서버 통신
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
