//
//  LoginCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//

import ComposableArchitecture

public struct Login: Reducer {
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case apple
        case kakao
        case loginResponse(TaskResult<User>)
    }
    
    @Dependency(\.authenticationClient) var authenticationClient
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .apple:
            return .run { send in
                do {
                    let user = try await authenticationClient.login(.apple)
                    await send(.loginResponse(.success(user)))
                } catch {
                    await send(.loginResponse(.failure(error)))
                }
            }
            
        case .kakao:
            return .run { send in
                do {
                    let user = try await authenticationClient.login(.kakao)
                    await send(.loginResponse(.success(user)))
                } catch {
                    await send(.loginResponse(.failure(error)))
                }
            }
            
        case let .loginResponse(.success(user)):
            print("user", user)
            return .none
            
        case let .loginResponse(.failure(error)):
            print("error", error)
            return .none
        }
    }
}
