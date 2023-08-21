//
//  KakaoLoginButton.swift
//  
//
//  Created by Joy on 2023/08/21.
//

import SwiftUI

struct KakaoLoginButton: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
//            HStack(spacing: 0) {
                Image("kakao_login", bundle: Bundle.module)
                .resizable()
//
//                Spacer()
//
//                Text("카카오 로그인")
//                    .font(.system(size: 30))
//                    .foregroundColor(.black.opacity(0.85))
//
//                Spacer()
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundColor(Color("bg_kakao"))
//            )
        }
    }
}

struct KakaoLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginButton {}
    }
}
