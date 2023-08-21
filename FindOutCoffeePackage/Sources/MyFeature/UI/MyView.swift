//
//  MyView.swift
//  
//
//  Created by 10004 on 2023/08/19.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        VStack(spacing: 60) {
            ProfileView()
                .padding(.vertical)

            InformationView()
            
            Spacer()
            
            LogoutView()
        }
        .padding()
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
