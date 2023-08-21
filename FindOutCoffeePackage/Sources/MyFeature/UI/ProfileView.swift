//
//  ProfileView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("만사만사만사")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
            
            Spacer()
            
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 72, height: 72)
                    .clipped()
            } placeholder: {
                
            }
            .foregroundColor(.clear)
            .frame(width: 72, height: 72)
            .background(.black.opacity(0.1))
            .cornerRadius(72)
            .overlay(
                RoundedRectangle(cornerRadius: 72)
                    .inset(by: 0.25)
                    .stroke(.black.opacity(0.1), lineWidth: 0.5)
            )
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
