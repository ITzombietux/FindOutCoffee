//
//  RecommendationView.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import SwiftUI

import ComposableArchitecture

extension ReviewContentView {
    public struct RecommendationView: View {
        @Binding var isRecommend: Bool?
        
        public init(isRecommend: Binding<Bool?>) {
            self._isRecommend = isRecommend
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("이 음료를 추천하나요?")
                    .font(.system(size: 25, weight: .bold))
                
                HStack(spacing: 10) {
                    selectionCell(imageName: "hand.thumbsup.fill", title: "추천", isSelected: isRecommend ?? false) {
                        self.isRecommend = true
                    }
                    selectionCell(imageName: "hand.thumbsdown.fill", title: "비추천", isSelected: !(isRecommend ?? false)) {
                        self.isRecommend = false
                    }
                }
                
                Spacer()
            }
        }
        
        private func selectionCell(imageName: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
            Button {
                action()
            } label: {
                VStack(spacing: 20) {
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(isSelected ? .white : .black)
                    
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(isSelected ? .white : .black)
                }
                .frame(width: (UIScreen.main.bounds.width - 40 - 5) / 2, height: 150)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.mainColor)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke()
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.RecommendationView(isRecommend: .constant(true))
    }
}
