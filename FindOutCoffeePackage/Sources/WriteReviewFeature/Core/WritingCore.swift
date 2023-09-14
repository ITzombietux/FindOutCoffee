//
//  WritingCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import Foundation

import ComposableArchitecture

public struct Writing: Reducer {
    public struct State: Equatable {
        public var photo: [Data]?
        public var text: String?
    }
    
    public enum Action {
        case selectPhoto([Data])
        case editText(String)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .selectPhoto(photo):
            state.photo = photo
            return .none
            
        case let .editText(text):
            state.text = text
            return .none
        }
    }
}
