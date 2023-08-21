//
//  InformationView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack() {
            Divider()
            
            row(title: "로그인 정보", body: "카카오톡")
            
            Divider()
            
            row(title: "버전 정보", body: "1.0.0")
            
            Divider()
            
            row(title: "개인정보 취급 방침", body: "")
            
            Divider()
            
            row(title: "이용약관", body: "")
            
            Divider()
        }
    }
    
    private func row(title: String, body: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
            
            Spacer()
            
            Text(body)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.trailing)
                .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
            
            Image(systemName: "chevron.right")
                .frame(width: 30, height: 30)
        }
        .frame(height: 48)
        .padding(.horizontal)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
