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
        private let selection: String?
        private let action: (String) -> Void
        
        init(store: String, drinks: [String], selection: String?, action: @escaping (String) -> Void) {
            self.store = store
            self.drinks = drinks
            self.selection = selection
            self.action = action
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("\(store)에서 구매한 음료 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                ForEach(self.drinks, id: \.self) { drink in
                    SelectionCell(title: drink, isSelected: drink == selection) {
                        action(drink)
                    }
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
            selection: nil
        ) { drink in
                
        }
    }
}
