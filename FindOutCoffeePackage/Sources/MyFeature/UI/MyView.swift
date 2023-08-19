//
//  MyView.swift
//  
//
//  Created by 10004 on 2023/08/19.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("만사만사만사")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
            
            Spacer()
            
            AsyncImage(url: URL(string: "")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 72, height: 72)
                    .clipped()
            } placeholder: {
                EmptyView()
                    .background(.gray)
            }
            .cornerRadius(72)
            .overlay(
                RoundedRectangle(cornerRadius: 72)
                    .inset(by: 0.25)
                    .stroke(.black.opacity(0.1), lineWidth: 0.5)
            )
            .background(.gray)
        }
        .padding()
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
