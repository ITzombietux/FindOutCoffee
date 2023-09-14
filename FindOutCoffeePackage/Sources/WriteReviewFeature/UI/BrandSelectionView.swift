//
//  BrandSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/16.
//

import SwiftUI

import ComposableArchitecture

extension ReviewContentView {
    struct BrandSelectionView: View {
        private let store: StoreOf<BrandSelection>
        
        init(store: StoreOf<BrandSelection>) {
            self.store = store
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("브랜드 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    DynamicWidthGrid(elementCount: viewStore.state.brands.count) { index in
                        SelectionCell(
                            title: viewStore.state.brands[index],
                            isSelected: viewStore.state.selectedIndex == index
                        ) {
                            viewStore.send(.select(index))
                        }
                    }
                }
            }
        }
    }
}

struct BrandSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.BrandSelectionView(store: Store(initialState: BrandSelection.State(), reducer: { BrandSelection() }))
    }
}
