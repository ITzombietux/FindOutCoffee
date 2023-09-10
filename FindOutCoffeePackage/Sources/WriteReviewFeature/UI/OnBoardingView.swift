//
//  OnBoardingView.swift
//  
//
//  Created by 김혜지 on 2023/09/09.
//

import SwiftUI

extension ReviewContentView {
    struct OnBoardingView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                
                Text("온보딩 뷰 입니당")
                    .font(.system(size: 25, weight: .bold))
                
                Spacer()
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.OnBoardingView()
    }
}
