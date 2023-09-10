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
                StepProgressView(totalStep: viewStore.state.steps.count, currentStep: viewStore.state.currentStep + 1)
                    .tint(Color.mainColor)
            }
            
            reviewContentView()
            
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ReviewButton(
                    isEnabled: viewStore.state.nextButtonIsEnabled,
                    step: viewStore.state.steps[viewStore.state.currentStep]
                ) {
                    viewStore.send(.nextButtonTapped)
                }
            }
        }
        .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
        .padding(.horizontal, 20)
    }
    
    private func navigationBar() -> some View {
        WithViewStore(self.store, observe: \.currentStep) { viewStore in
            HStack {
                Button {
                    viewStore.send(.backButtonTapped)
                } label: {
                    Image(systemName: viewStore.state == 0 ? "multiply" : "chevron.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(.black)
                
                Spacer()
            }
            .frame(height: 44)
        }
    }
    
    @ViewBuilder
    private func reviewContentView() -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.state.isLoading {
                activityIndicator()
            } else {
                ReviewContentView(step: viewStore.state.steps[viewStore.state.currentStep], store: self.store.scope(state: \.content, action: Review.Action.content))
            }
        }
    }
    
    private func activityIndicator() -> some View {
        VStack {
            Spacer()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .mainColor))
            
            Spacer()
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
