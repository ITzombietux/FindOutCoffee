//
//  DrinkSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct DrinkSelectionView: View {
        private let store: String
        private let drinks: [String]
        @State private var input: String = ""
        @Binding var selection: String?
        
        init(store: String, drinks: [String], selection: Binding<String?>) {
            self.store = store
            self.drinks = drinks
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(store)에서 구매한 음료 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                DynamicWidthGrid(elements: self.drinks) { drink in
                    SelectionCell(title: drink, isSelected: drink == selection) {
                        self.selection = drink
                    }
                }
            }
        }
        
        private func addButtonCell() -> some View {
            Button {
                
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
            .padding(.vertical, 2)
        }
        
        private func inputView() -> some View {
            TextField("음료 이름을 입력해주세요!", text: $input)
                .padding(5)
                .background(
                    Capsule()
                        .stroke()
                        .foregroundColor(.gray)
                )
        }
    }
}

struct DrinkSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.DrinkSelectionView(
            store: ReviewContent.Store.convenienceStore.description,
            drinks: ["아메리카노", "카페라떼", "바닐라라떼"],
            selection: .constant(nil)
        )
    }
}
