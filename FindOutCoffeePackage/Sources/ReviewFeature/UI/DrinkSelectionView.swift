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
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(self.drinks, id: \.self) { drink in
                            SelectionCell(title: drink, isSelected: drink == selection) {
                                self.selection = drink
                            }
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical)
                }
            }
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
