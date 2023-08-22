//
//  ProfileView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

import ComposableArchitecture

struct ProfileView: View {
    let store: StoreOf<My>
    
    init(store: StoreOf<My>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: \.user) { viewStore in
            HStack(alignment: .center) {
                Text(viewStore.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                
                Spacer()
                
                AsyncImage(url: URL(string: viewStore.imageURL)) { image in
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
}
