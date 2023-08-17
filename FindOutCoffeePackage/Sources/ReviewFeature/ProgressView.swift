//
//  ProgressView.swift
//  
//
//  Created by 김혜지 on 2023/08/13.
//

import SwiftUI

struct ProgressView: View {
    private let totalStep: Int
    private let currentStep: Int
    
    init(totalStep: Int, currentStep: Int) {
        self.totalStep = totalStep
        self.currentStep = currentStep
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(currentStep) / \(totalStep)")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.gray)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(.gray)
                
                GeometryReader { geometry in
                    Capsule()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width / CGFloat(totalStep) * CGFloat(currentStep))
                        .animation(.spring(), value: currentStep)
                }
            }
            .frame(width: .infinity, height: 8)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(totalStep: 7, currentStep: 3)
    }
}
