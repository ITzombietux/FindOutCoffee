//
//  ReviewView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

import SwiftUI

struct ReviewView: View {
    private let store: StoreOf<Review>
    
    init(store: StoreOf<Review>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            navigationBar()
            
            WithViewStore(self.store, observe: \.step) { viewStore in
                ProgressView(currentStep: viewStore.state.rawValue)
                
                ReviewContentView(store: self.store.scope(state: \.content, action: Review.Action.content))
            }
            
            Spacer()
            
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ReviewButton(step: viewStore.state.step) {
                    viewStore.send(.nextButtonTapped)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func navigationBar() -> some View {
        HStack {
            Image(systemName: "chevron.left")
            
            Spacer()
        }
        .frame(height: 44)
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(store:
                    Store(initialState: Review.State(),
                          reducer: { Review() })
        )
    }
}
