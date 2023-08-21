//
//  MyView.swift
//  
//
//  Created by 10004 on 2023/08/19.
//

import SwiftUI

public struct MyView: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            ProfileView()
                .padding()
                .padding(.vertical)

            InformationView()
                .padding(.vertical)
            
            Spacer()
            
            LogoutView()
                .padding(.horizontal)
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
