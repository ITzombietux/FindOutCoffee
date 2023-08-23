//
//  LoginView.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import ComposableArchitecture
import UserDefaultsDependency
import DesignSystem

import SwiftUI

public struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    private let store: StoreOf<Login>
    
    public init(store: StoreOf<Login> = Store(initialState: Login.State(), reducer: { Login() })) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 10) {
                Spacer()
                
                Image("커피를찾아서")
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                Spacer()
                
                AppleLoginButton { result in
                    viewStore.send(.apple(result))
                }
                .frame(height: 50)
                
                KakaoLoginButton {
                    viewStore.send(.kakao)
                }
                .frame(height: 50)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
            .onChange(of: viewStore.isLoggedIn) { newValue in
                if newValue {
                    NotificationCenter.default.post(name: Notification.Name.dismissLoginView, object: nil)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: Login.State(), reducer: { Login() }))
    }
}

public extension Notification.Name {
    static let dismissLoginView = Notification.Name("dismissLoginView")
}
