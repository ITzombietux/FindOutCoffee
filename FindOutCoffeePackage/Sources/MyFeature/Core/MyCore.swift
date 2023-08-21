//
//  MyCore.swift
//  
//
//  Created by 10004 on 2023/08/19.
//

import Foundation

import ComposableArchitecture
import UserDefaultsDependency
import AuthorizationDependency

public struct My: Reducer {
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case logoutButtonTapped
        case withdrawalButtonTapped
    }
    
    @Dependency(\.authenticationClient) var authenticationClient
    @Dependency(\.loginClient) var loginClient
    @Dependency(\.userDefaults) var userDefaultsClient
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
            
        case .logoutButtonTapped:
            return .none
            
        case .withdrawalButtonTapped:
            return .none
        }
    }
}
