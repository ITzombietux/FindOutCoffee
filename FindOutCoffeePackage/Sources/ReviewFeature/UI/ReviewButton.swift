//
//  ReviewButton.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

import DesignSystem

struct ReviewButton: View {
    private let isEnabled: Bool
    private let step: Review.Step
    private let action: () -> Void
    
    init(isEnabled: Bool, step: Review.Step, action: @escaping () -> Void) {
        self.isEnabled = isEnabled
        self.step = step
        self.action = action
    }
    
    var body: some View {
        Button {
            if isEnabled {
                action()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(isEnabled ? Color.mainColor : .secondary)
                
                Text(self.step == .writing ? "작성 완료" : "다음")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(height: 50)
    }
}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton(isEnabled: true, step: .store) {
            
        }
    }
}
