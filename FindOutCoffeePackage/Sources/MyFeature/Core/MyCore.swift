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
import LoginFeature

public struct My: Reducer {
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        public var loggedInFlag: Bool = false
        public var login: Login.State?
        public var user: LoginApiEntity = .mock
        
        public init() {}
    }
    
    public enum Action {
        case alert(PresentationAction<Alert>)
        case onAppear
        case login(Login.Action)
        case logoutButtonTapped
        case withdrawalButtonTapped
        case logoutResponse(TaskResult<Bool>)
        case withdrawalResponse(TaskResult<Bool>)
        case userResponse(TaskResult<LoginApiEntity>)
        
        public enum Alert {
            case confirmLogout
            case confirmWithdrawal
        }
    }
    
    @Dependency(\.authenticationClient) var authenticationClient
    @Dependency(\.loginClient) var loginClient
    @Dependency(\.userDefaults) var userDefaultsClient
    
    public init() {}
    
    public var body: some ReducerOf<Self> { Reduce<State, Action> {
        state, action in
        switch action {
        case .onAppear:
            return .run { send in
                await send(
                    .userResponse(
                        await TaskResult {
                            try await self.loginClient.user()
                        }
                    )
                )
            }
            
        case let .userResponse(.success(user)):
            state.user = user
            return .none
            
        case let .userResponse(.failure(error)):
            return .none
            
        case .logoutButtonTapped:
            state.alert = .logout()
            return .none
            
        case .withdrawalButtonTapped:
            state.alert = .withdrawal()
            return .none
            
        case .alert(.presented(.confirmLogout)):
            guard let snsLoginType = SNSLoginType(rawValue: state.user.type) else { return .none }
            return .run { send in
                await send(
                    .logoutResponse(
                        await TaskResult {
                            guard try await self.authenticationClient.logout(snsLoginType) else { return false }
                            return try await self.loginClient.logout()
                        }
                    )
                )
            }
            
        case let .logoutResponse(.success(isLoggedOut)):
            state.loggedInFlag.toggle()
            state.user = .mock
            return .none
            
        case let .logoutResponse(.failure(error)):
            return .none
            
        case .alert(.presented(.confirmWithdrawal)):
            return .run { send in
                await send(
                    .withdrawalResponse(
                        await TaskResult {
                            try await self.loginClient.withdrawal()
                        }
                    )
                )
            }
            
        case let .withdrawalResponse(.success(isLoggedOut)):
            state.loggedInFlag.toggle()
            state.user = .mock
            return .none
            
        case let .withdrawalResponse(.failure(error)):
            return .none
            
        case .alert:
            return .none
            
        case .login:
            return .none
        }
    }
    .ifLet(\.$alert, action: /Action.alert)
    .ifLet(\.login, action: /Action.login) {
        Login()
    }
    }
}

extension AlertState where Action == My.Action.Alert {
    static func logout() -> Self {
        Self {
            TextState("로그아웃 하시겠습니까?")
        } actions: {
            ButtonState(role: .cancel) {
                TextState("취소")
            }
            
            ButtonState(role: .destructive, action: .confirmLogout) {
                TextState("네")
            }
        }
    }
    
    static func withdrawal() -> Self {
        Self {
            TextState("정말로 회원탈퇴 하시겠습니까?")
        } actions: {
            ButtonState(role: .cancel) {
                TextState("취소")
            }
            
            ButtonState(role: .destructive, action: .confirmWithdrawal) {
                TextState("네")
            }
        } message: {
            TextState(
              """
              회원탈퇴를 하시면 다시 가입이 가능합니다 :D
              """
            )
        }
    }
}
