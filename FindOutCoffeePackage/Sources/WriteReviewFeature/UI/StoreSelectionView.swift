//
//  StoreSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

import ComposableArchitecture

extension ReviewContentView {
    struct StoreSelectionView: View {
        private let store: StoreOf<StoreSelection>
        
        init(store: StoreOf<StoreSelection>) {
            self.store = store
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("이 음료 어디서 샀어요?")
                    .font(.system(size: 25, weight: .bold))
                
                WithViewStore(self.store, observe: \.selectedStore) { viewStore in
                    HStack(spacing: 10) {
                        selectionCell(
                            imageName: "hand.thumbsup.fill",
                            title: Store.cafe.description,
                            isSelected: viewStore.state == .cafe
                        ) {
                            viewStore.send(.select(.cafe))
                        }
                        
                        selectionCell(
                            imageName: "hand.thumbsdown.fill",
                            title: Store.convenienceStore.description,
                            isSelected: viewStore.state == .convenienceStore
                        ) {
                            viewStore.send(.select(.convenienceStore))
                        }
                    }
                }
                
                Spacer()
            }
        }
        
        private func selectionCell(imageName: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
            Button {
                action()
            } label: {
                VStack(spacing: 20) {
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(isSelected ? .white : .black)
                    
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(isSelected ? .white : .black)
                }
                .frame(width: (UIScreen.main.bounds.width - 40 - 5) / 2, height: 150)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.mainColor)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke()
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct StoreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.StoreSelectionView(store: Store(initialState: StoreSelection.State(), reducer: { StoreSelection() }))
    }
}
