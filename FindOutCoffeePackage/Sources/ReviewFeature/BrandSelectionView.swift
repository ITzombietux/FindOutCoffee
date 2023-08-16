//
//  BrandSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/16.
//

import SwiftUI

extension ReviewContentView {
    struct BrandSelectionView: View {
        private let brands: [String]
        private let selection: String?
        private let action: (String) -> Void
        
        init(brands: [String], selection: String?, action: @escaping (String) -> Void) {
            self.brands = brands
            self.selection = selection
            self.action = action
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("카페 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                ForEach(self.brands, id: \.self) { brand in
                    SelectionCell(
                        title: brand,
                        isSelected: selection == brand
                    ) {
                        action(brand)
                    }
                }
            }
        }
    }
}

struct BrandSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.BrandSelectionView(
            brands: ["스타벅스", "투썸플레이스", "이디야", "할리스"], selection: nil) { brand in
                
            }
    }
}
