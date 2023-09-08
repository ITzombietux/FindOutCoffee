//
//  ReviewDetailView.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import SwiftUI

import ComposableArchitecture

public struct ReviewDetailView: View {
    
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            navigationBar()
            
            Spacer()
        }
    }
    
    private func navigationBar() -> some View {
        HStack {
            Button {
//                viewStore.send(.backButtonTapped)
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: 44)
    }
}
