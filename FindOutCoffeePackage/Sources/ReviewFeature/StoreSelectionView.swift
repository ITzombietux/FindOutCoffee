//
//  StoreSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct StoreSelectionView: View {
        private let selection: ReviewContent.Store?
        private let action: (ReviewContent.Store) -> Void
        
        init(selection: ReviewContent.Store?, action: @escaping (ReviewContent.Store) -> Void) {
            self.selection = selection
            self.action = action
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("이 음료 어디서 샀어요?")
                    .font(.system(size: 25, weight: .bold))
                
                SelectionCell(
                    title: "🏪 \(ReviewContent.Store.convenienceStore.description)",
                    isSelected: selection == .convenienceStore
                ) {
                    action(.convenienceStore)
                }
                
                SelectionCell(
                    title: "☕️ \(ReviewContent.Store.cafe.description)",
                    isSelected: selection == .cafe
                ) {
                    action(.cafe)
                }
            }
        }
    }
}

struct StoreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.StoreSelectionView(selection: nil) { _ in
            
        }
    }
}
