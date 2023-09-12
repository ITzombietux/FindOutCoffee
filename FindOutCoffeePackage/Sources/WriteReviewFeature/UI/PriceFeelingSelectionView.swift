//
//  PriceSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct PriceFeelingSelectionView: View {
        private let priceFeelings: [String]
        @Binding var selectedFeeling: String?
        
        init(priceFeelings: [String], selectedFeeling: Binding<String?>) {
            self.priceFeelings = priceFeelings
            self._selectedFeeling = selectedFeeling
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("가격이 적당한 것 같나요?")
                    .font(.system(size: 25, weight: .bold))
                
                DynamicWidthGrid(elements: self.priceFeelings) { priceFeeling in
                    SelectionCell(title: priceFeeling, isSelected: selectedFeeling == priceFeeling) {
                        self.selectedFeeling = priceFeeling
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct PriceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.PriceFeelingSelectionView(priceFeelings: ["김만구는", "행복에 살텐데", "나", "없이도", "행복하게", "자알", "지내려나"], selectedFeeling: .constant(nil))
    }
}
