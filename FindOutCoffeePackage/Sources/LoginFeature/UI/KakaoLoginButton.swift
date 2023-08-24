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
            Image("kakao_login", bundle: Bundle.module)
                .resizable()
        }
    }
}

struct KakaoLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginButton {}
    }
}
