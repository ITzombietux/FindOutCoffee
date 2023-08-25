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
            HStack(alignment: .center, spacing: 8) {
                Spacer()
                
                Image("카카오로고")
                    .resizable()
                    .frame(width: 16, height: 16)
                
                Text("카카오로 시작하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.kakaoTitleColor)
                
                Spacer()
            }
            .frame(height: 50)
            .background(Color.kakaoBackgroundColor)
            .cornerRadius(8)
        }
    }
}

struct KakaoLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginButton {}
    }
}
