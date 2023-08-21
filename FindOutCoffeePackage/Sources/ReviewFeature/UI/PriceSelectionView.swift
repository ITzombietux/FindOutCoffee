//
//  PriceSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct PriceSelectionView: View {
        private let prices: [String]
        @Binding var selection: String?
        
        init(prices: [String], selection: Binding<String?>) {
            self.prices = prices
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("가격이 적당한 것 같나요?")
                    .font(.system(size: 25, weight: .bold))
                
                ForEach(self.prices, id: \.self) { price in
                    SelectionCell(title: price, isSelected: selection == price) {
                        self.selection = price
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct PriceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.PriceSelectionView(prices: ["너무 비싸요", "비싸지만 맛있어요"], selection: .constant(nil))
    }
}
