//
//  DrinkSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

import ComposableArchitecture

extension ReviewContentView {
    struct DrinkSelectionView: View {
        private let store: StoreOf<DrinkSelection>
        
        init(store: StoreOf<DrinkSelection>) {
            self.store = store
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("음료 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                inputView()
                
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    DynamicWidthGrid(elementCount: viewStore.state.drinks.count + 1) { index in
                        drinkSelectionCell(at: index)
                    }
                }
            }
        }
        
        private func addButtonCell() -> some View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                Button {
                    viewStore.send(.addButtonTapped)
                } label: {
                    Text("+")
                        .font(.system(size: 15, weight: .medium))
                        .padding(8)
                        .background(
                            Capsule()
                                .stroke()
                                .foregroundColor(.gray)
                        )
                }
                .foregroundColor(.black)
                .padding(.vertical, 2)
            }
        }
        
        @ViewBuilder
        private func inputView() -> some View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                if viewStore.isEnabledToAdd {
                    TextField("음료 이름을 입력해주세요!", text: viewStore.binding(get: \.writtenDrink, send: { .writeDrink($0) }))
                        .padding(5)
                        .background(
                            Capsule()
                                .stroke()
                                .foregroundColor(.gray)
                        )
                        .frame(width: UIScreen.main.bounds.width - 40)
                }
            }
        }
        
        @ViewBuilder
        private func drinkSelectionCell(at index: Int) -> some View {
            if index == 0 {
                addButtonCell()
            } else {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    SelectionCell(
                        title: viewStore.state.drinks[index - 1],
                        isSelected: viewStore.state.selectedIndex == index - 1
                    ) {
                        viewStore.send(.select(index - 1))
                    }
                }
            }
        }
    }
}

struct DrinkSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.DrinkSelectionView(store: Store(initialState: DrinkSelection.State(), reducer: { DrinkSelection() }))
    }
}
