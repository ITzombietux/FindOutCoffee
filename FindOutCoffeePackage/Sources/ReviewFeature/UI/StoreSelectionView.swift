//
//  StoreSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct StoreSelectionView: View {
        @Binding var selection: ReviewContent.Store?
        
        init(selection: Binding<ReviewContent.Store?>) {
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("이 음료 어디서 샀어요?")
                    .font(.system(size: 25, weight: .bold))
                
                SelectionCell(
                    title: "🏪 \(ReviewContent.Store.convenienceStore.description)",
                    isSelected: selection == .convenienceStore
                ) {
                    self.selection = .convenienceStore
                }
                
                SelectionCell(
                    title: "☕️ \(ReviewContent.Store.cafe.description)",
                    isSelected: selection == .cafe
                ) {
                    self.selection = .cafe
                }
            }
        }
    }
}

struct StoreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.StoreSelectionView(selection: .constant(nil))
    }
}
