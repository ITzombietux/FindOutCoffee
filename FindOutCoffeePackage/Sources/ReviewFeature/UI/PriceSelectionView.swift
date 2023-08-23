//
//  PriceSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct PriceSelectionView: View {
        private let priceFeelings: [String]
        @Binding var selectedFeeling: String?
        @Binding var isRecommend: Bool?
        
        init(priceFeelings: [String], selectedFeeling: Binding<String?>, isRecommend: Binding<Bool?>) {
            self.priceFeelings = priceFeelings
            self._selectedFeeling = selectedFeeling
            self._isRecommend = isRecommend
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("가격이 적당한 것 같나요?")
                    .font(.system(size: 25, weight: .bold))
                
                ForEach(self.priceFeelings, id: \.self) { priceFeeling in
                    SelectionCell(title: priceFeeling, isSelected: selectedFeeling == priceFeeling) {
                        self.selectedFeeling = priceFeeling
                    }
                }
                
                Text("추천 / 비추천")
                    .font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 20) {
                    SelectionCell(title: "추천👍", isSelected: isRecommend ?? false) {
                        self.isRecommend = true
                    }
                    
                    SelectionCell(title: "비추천👎", isSelected: !(isRecommend ?? true)) {
                        self.isRecommend = false
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct PriceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.PriceSelectionView(priceFeelings: ["너무 비싸요", "비싸지만 맛있어요"], selectedFeeling: .constant(nil), isRecommend: .constant(nil))
    }
}
