//
//  LoginView.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import ComposableArchitecture
import UserDefaultsDependency

import SwiftUI

public struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    private let store: StoreOf<Login>
    
    public init(store: StoreOf<Login> = Store(initialState: Login.State(), reducer: { Login() })) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                AppleLoginButton { result in
                    
                }
                
                Button("카카오톡 로그인") {
                    viewStore.send(.kakao)
                }
            }
            .onChange(of: viewStore.isLoggedIn) { newValue in
                if newValue {
                    self.dismiss()
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
