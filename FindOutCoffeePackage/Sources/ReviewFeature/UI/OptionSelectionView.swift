//
//  OptionSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct OptionSelectionView: View {
        @Binding var size: ReviewContent.Size?
        @Binding var iceOrHot: ReviewContent.IceOrHot?
        
        init(size: Binding<ReviewContent.Size?>, iceOrHot: Binding<ReviewContent.IceOrHot?>) {
            self._size = size
            self._iceOrHot = iceOrHot
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("옵션을 선택해 주세요!")
                    .font(.system(size: 25, weight: .bold))
                    .padding(.bottom, 20)
                
                Text("사이즈")
                    .font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 10) {
                    SelectionCell(title: "Small", isSelected: size == .small) {
                        self.size = .small
                    }
                    
                    SelectionCell(title: "Medium", isSelected: size == .medium) {
                        self.size = .medium
                    }
                    
                    SelectionCell(title: "Large", isSelected: size == .large) {
                        self.size = .large
                    }
                }
                .padding(.bottom, 20)
                
                Text("ICE / HOT")
                    .font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 10) {
                    SelectionCell(title: "❄️ ICE", isSelected: iceOrHot == .ice) {
                        self.iceOrHot = .ice
                    }
                    
                    SelectionCell(title: "🔥 HOT", isSelected: iceOrHot == .hot) {
                        self.iceOrHot = .hot
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct OptionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.OptionSelectionView(size: .constant(nil), iceOrHot: .constant(nil))
    }
}
