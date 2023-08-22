//
//  MyView.swift
//  
//
//  Created by 10004 on 2023/08/19.
//

import SwiftUI

import ComposableArchitecture

public struct MyView: View {
    let store: StoreOf<My> = Store(initialState: My.State()) {
        My()
    }
    
    public init() {}
    
    public var body: some View {
        WithViewStore(self.store, observe: \.user) { viewStore in
            VStack(spacing: 0) {
                ProfileView(store: self.store)
                    .padding()
                    .padding(.vertical)
                
                InformationView(store: self.store)
                    .padding(.vertical)
                
                Spacer()
                
                LogoutView(store: self.store)
                    .padding(.horizontal)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
        }
    }
}
