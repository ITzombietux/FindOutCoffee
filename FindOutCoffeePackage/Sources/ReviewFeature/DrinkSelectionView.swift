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
        
        init(store: String) {
            self.store = store
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("\(store)에서 구매한 음료 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                
            }
        }
    }
}

struct DrinkSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.DrinkSelectionView(store: ReviewContent.Store.convenienceStore.description)
    }
}
