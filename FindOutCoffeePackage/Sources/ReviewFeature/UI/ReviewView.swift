//
//  ReviewView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture
import DesignSystem

import SwiftUI

public struct ReviewView: View {
    private let store: StoreOf<Review>
    
    public init(store: StoreOf<Review> = Store(initialState: Review.State(), reducer: { Review() })) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            navigationBar()
            
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ProgressView(totalStep: viewStore.state.steps.count, currentStep: viewStore.state.currentStep + 1)
                    .tint(Color.mainColor)
                
                ReviewContentView(step: viewStore.state.steps[viewStore.state.currentStep], store: self.store.scope(state: \.content, action: Review.Action.content))
            }
            
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ReviewButton(step: viewStore.state.steps[viewStore.state.currentStep]) {
                    viewStore.send(.nextButtonTapped)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func navigationBar() -> some View {
        WithViewStore(self.store, observe: \.currentStep) { viewStore in
            HStack {
                Button {
                    viewStore.send(.backButtonTapped)
                } label: {
                    Image(systemName: viewStore.state == 0 ? "multiply" : "chevron.left")
                        .foregroundColor(Color.mainColor)
                }
                
                Spacer()
            }
            .frame(height: 44)
        }
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

public extension Notification.Name {
    static let dismissReviewView = Notification.Name("dismissReviewView")
}
