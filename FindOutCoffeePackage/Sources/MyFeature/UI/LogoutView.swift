//
//  LogoutView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

struct LogoutView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button {
                
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
                .background(Color(red: 0.169, green: 0.565, blue: 0.851))
                .cornerRadius(8)
            }
            
            Button {
                
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

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
