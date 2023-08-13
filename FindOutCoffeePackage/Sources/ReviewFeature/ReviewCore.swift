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
        case drink = 2
        case options = 3
        case price = 4
        case writing = 5
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
        case content(ReviewContent.Action)
    }
    
    init() {}
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                switch state.step {
                case .store:
                    state.step = .drink
                case .drink:
                    state.step = .options
                case .options:
                    state.step = .price
                case .price:
                    state.step = .writing
                case .writing:
                    // TODO: 서버 통신
                    break
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
