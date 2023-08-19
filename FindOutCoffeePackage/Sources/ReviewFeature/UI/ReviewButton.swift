//
//  ReviewButton.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

struct ReviewButton: View {
    private let step: Review.Step
    private let action: () -> Void
    
    init(step: Review.Step, action: @escaping () -> Void) {
        self.step = step
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.blue)
                
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
        ReviewButton(step: .store) {
            
        }
    }
}
