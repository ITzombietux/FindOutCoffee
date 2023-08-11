//
//  LoginView.swift
//  
//
//  Created by 김혜지 on 2023/08/09.
//

import ComposableArchitecture

import SwiftUI

public struct LoginView: View {
    private let store: StoreOf<Login>
    
    public init(store: StoreOf<Login> = Store(initialState: Login.State(), reducer: { Login() })) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                Button("애플 로그인") {
                    viewStore.send(.apple)
                }
                
                Button("카카오톡 로그인") {
                    viewStore.send(.kakao)
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
