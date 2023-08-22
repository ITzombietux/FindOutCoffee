//
//  LogoutView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

import ComposableArchitecture
import DesignSystem

struct LogoutView: View {
    let store: StoreOf<My>
    
    init(store: StoreOf<My>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: \.login) { viewStore in
            VStack(alignment: .center, spacing: 10) {
                Button {
                    viewStore.send(.logoutButtonTapped)
                } label: {
                    HStack(alignment: .center, spacing: 4) {
                        Text("로그아웃")
                            .font(.system(size: 14, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.mainColor)
                    .cornerRadius(8)
                }
                
                Button {
                    viewStore.send(.withdrawalButtonTapped)
                } label: {
                    Text("커피를 찾아서를 탈퇴하시려면 이곳을 눌러주세요")
                        .font(.system(size: 10))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                }
            }
            .padding()
        }
    }
}
