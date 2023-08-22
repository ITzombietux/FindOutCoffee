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
                StoreSelectionView(selection: viewStore.binding(get: \.optional, send: { .selectStore($0 ?? .cafe) }))
            }
            
        case .brand:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                BrandSelectionView(brands: viewStore.state.brands ?? [], selection: viewStore.binding(get: \.brand, send: { .selectBrand($0 ?? "") }))
            }
            
        case .category:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                CategorySelectionView(categories: viewStore.state.categories ?? [], selection: viewStore.binding(get: \.category, send: { .selectCategory($0 ?? "") }))
            }
            
        case .drink:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                DrinkSelectionView(store: viewStore.state.store?.description ?? "", drinks: viewStore.state.drinks ?? [], selection: viewStore.binding(get: \.drink, send: { .selectDrink($0 ?? "")   }))
            }
            
        case .options:
            WithViewStore(self.store, observe:  { $0 }) { viewStore in
                OptionSelectionView(
                    size:
                        viewStore.binding(
                            get: \.size,
                            send: { .selectSize($0 ?? .small) }
                        ),
                    iceOrHot:
                        viewStore.binding(
                            get: \.iceOrHot,
                            send: { .selectIceOrHot($0 ?? .ice) }
                        )
                )
            }
            
        case .price:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                PriceSelectionView(
                    priceFeelings: viewStore.priceFeelings ?? [],
                    selectedFeeling:
                        viewStore.binding(
                            get: \.priceFeeling,
                            send: { .selectPriceFeeling($0 ?? "") }
                        ),
                    isRecommend:
                        viewStore.binding(
                            get: \.isRecommend,
                            send: { .selectRecommendation($0 ?? false) }
                        )
                )
            }
            
        case .writing:
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                WritingView(
                    photo: viewStore.binding(
                        get: \.photo,
                        send: { .selectPhoto($0 ?? []) }
                    ),
                    text: viewStore.binding(
                        get: \.text,
                        send: { .editText($0 ?? "") }
                    )
                )
            }
        }
    }
}

struct ReviewContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView(store: Store(initialState: ReviewContent.State(), reducer: { ReviewContent() }))
    }
}
