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
        @Binding var selection: String?
        
        init(
            brands: [String],
            selection: Binding<String?>
        ) {
            self.brands = brands
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("브랜드 이름이 뭐에요?")
                    .font(.system(size: 25, weight: .bold))
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(self.brands, id: \.self) { brand in
                            SelectionCell(
                                title: brand,
                                isSelected: selection == brand
                            ) {
                                self.selection = brand
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

struct BrandSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.BrandSelectionView(
            brands: ["스타벅스", "투썸플레이스", "이디야", "할리스"], selection: .constant(nil))
    }
}
