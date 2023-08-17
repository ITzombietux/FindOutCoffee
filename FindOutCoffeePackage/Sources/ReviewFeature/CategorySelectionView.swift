//
//  CategorySelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/16.
//

import SwiftUI

extension ReviewContentView {
    struct CategorySelectionView: View {
        private let categories: [String]
        @Binding var selection: String?
        
        init(categories: [String], selection: Binding<String?>) {
            self.categories = categories
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("구매한 음료 종류가 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                ForEach(self.categories, id: \.self) { category in
                    SelectionCell(title: category, isSelected: category == selection) {
                        self.selection = category
                    }
                }
            }
        }
    }
}

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.CategorySelectionView(
            categories: ["에스프레소", "콜드브루", "티바나", "요거트", "주스&에이드", "기타"],
            selection: .constant(nil))
    }
}
