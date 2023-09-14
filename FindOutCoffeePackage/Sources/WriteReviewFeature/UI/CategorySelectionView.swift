//
//  CategorySelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/16.
//

import SwiftUI

import ComposableArchitecture

extension ReviewContentView {
    struct CategorySelectionView: View {
        private let store: StoreOf<CategorySelection>
        
        init(store: StoreOf<CategorySelection>) {
            self.store = store
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("구매한 음료 종류가 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    DynamicWidthGrid(elementCount: viewStore.state.categories.count) { index in
                        SelectionCell(
                            title: viewStore.state.categories[index],
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

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.CategorySelectionView(store: Store(initialState: CategorySelection.State(), reducer: { CategorySelection() }))
    }
}
