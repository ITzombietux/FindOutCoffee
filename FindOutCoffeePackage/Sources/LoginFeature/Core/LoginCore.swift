//
//  LoginCore.swift
//  
//
//  Created by 김혜지 on 2023/08/08.
//
import Foundation

import ComposableArchitecture
import UserDefaultsDependency
import AuthorizationDependency

public struct Login: Reducer {
    public struct State: Equatable {
        public var loggedInFlag: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        case apple(AppleLoginHelper.AuthorizationResult)
        case kakao
        case loginResponse(TaskResult<User>)
        case saveUser(TaskResult<LoginApiEntity>)
    }
    
    @Dependency(\.authenticationClient) var authenticationClient
    @Dependency(\.loginClient) var loginClient
    @Dependency(\.userDefaults) var userDefaultsClient
    @Dependency(\.dismiss) var dismiss
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .apple(result):
            switch result {
            case let .success(authorization):
                return .run { send in
                    do {
                        let user = try await authenticationClient.appleLogin(authorization)
                        print("apple success", user)
                        await send(.loginResponse(.success(user)))
                    } catch {
                        await send(.loginResponse(.failure(error)))
                    }
                }
                
            case let .failure(error):
                return .none
            }
            
        case .kakao:
            return .run { send in
                do {
                    let user = try await authenticationClient.kakaoLogin()
                    await send(.loginResponse(.success(user)))
                } catch {
                    await send(.loginResponse(.failure(error)))
                }
            }
            
        case let .loginResponse(.success(user)):
            print("user", user)
            return .run { [identifier = user.id, profileImageURL = user.profileImageURL, nickname = user.nickname, snsLoginType = user.snsLoginType.rawValue] send in
                await send(
                    .saveUser(
                        await TaskResult {
                            try await self.loginClient.login(
                                .init(identifier: identifier, name: nickname, imageURL: profileImageURL ?? "", type: snsLoginType)
                            )
                        }
                    )
                )
            }
            
        case let .loginResponse(.failure(error)):
            print("error", error)
            return .none
            
        case let .saveUser(.success(response)):
            state.loggedInFlag.toggle()
            
            return .run { _ in
                UserDefaults.standard.setValue(response.identifier, forKey: "isLoggedInKey")
                UserDefaults.standard.setValue(response.type, forKey: "tpyeKey")
                UserDefaults.standard.setValue(response.name, forKey: "nameKey")
                UserDefaults.standard.setValue(response.imageURL, forKey: "imageURLKey")
            }
            
        case let .saveUser(.failure(error)):
            print(error)
            return .none
        }
    }
}
