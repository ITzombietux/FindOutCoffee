//
//  ProfileView.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import SwiftUI

import ComposableArchitecture
import SkeletonUI

struct ProfileView: View {
    let store: StoreOf<My>
    
    init(store: StoreOf<My>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: \.user) { viewStore in
            HStack(alignment: .center) {
                Text(viewStore.name)
                    .skeleton(with: viewStore.name.isEmpty)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                    .frame(width: 80, height: 30)
                
                Spacer()
                
                ZStack {
                    AsyncImage(url: URL(string: viewStore.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 72, height: 72)
                            .clipped()
                    } placeholder: {
                        
                    }
                    .skeleton(with: viewStore.imageURL.isEmpty)
                    .foregroundColor(.clear)
                    .frame(width: 72, height: 72)
                    .background(.black.opacity(0.1))
                    .cornerRadius(72)
                    .overlay(
                        RoundedRectangle(cornerRadius: 72)
                            .inset(by: 0.25)
                            .stroke(.black.opacity(0.1), lineWidth: 0.5)
                    )
                    
                    if viewStore.imageURL == "default" {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 72, height: 72)
                            .foregroundColor(.imagePlaceholderColor)
                    }
                }
            }
        }
    }
}
