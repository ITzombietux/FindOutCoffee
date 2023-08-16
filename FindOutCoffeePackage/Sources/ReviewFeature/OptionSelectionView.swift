//
//  OptionSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct OptionSelectionView: View {
        @Binding var iceOrHot: ReviewContent.IceOrHot?
        
        init(iceOrHot: Binding<ReviewContent.IceOrHot?>) {
            self._iceOrHot = iceOrHot
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("옵션을 선택해 주세요!")
                    .font(.system(size: 25, weight: .bold))
                
                // TODO: 사이즈 항목
                
                SelectionCell(title: "❄️ ICE", isSelected: iceOrHot == .ice) {
                    self.iceOrHot = .ice
                }
                
                SelectionCell(title: "🔥 HOT", isSelected: iceOrHot == .hot) {
                    self.iceOrHot = .hot
                }
            }
        }
    }
}

struct OptionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.OptionSelectionView(iceOrHot: .constant(nil))
    }
}
