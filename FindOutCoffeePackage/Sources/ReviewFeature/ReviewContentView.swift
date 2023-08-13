//
//  ReviewContentView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import ComposableArchitecture

import SwiftUI

struct ReviewContentView: View {
    private let step: Review.Step
    private let store: StoreOf<ReviewContent>
    
    init(step: Review.Step = .store, store: StoreOf<ReviewContent>) {
        self.step = step
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        switch step {
        case .store:
            WithViewStore(self.store, observe: \.store) { viewStore in
                StoreSelectionView(selection: viewStore.state) { store in
                    viewStore.send(.selectStore(store))
                }
            }
            
        case .drink:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                DrinkSelectionView(store: viewStore.state.store?.description ?? "")
            }
            
        case .options:
            OptionSelectionView()
            
        case .price:
            PriceSelectionView()
            
        case .writing:
            WritingView()
        }
    }
}

struct ReviewContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView(store: Store(initialState: ReviewContent.State(), reducer: { ReviewContent() }))
    }
}
