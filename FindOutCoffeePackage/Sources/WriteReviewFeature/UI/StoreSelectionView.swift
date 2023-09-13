//
//  StoreSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct StoreSelectionView: View {
        @Binding var selection: ReviewContent.Store?
        
        init(selection: Binding<ReviewContent.Store?>) {
            self._selection = selection
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("이 음료 어디서 샀어요?")
                    .font(.system(size: 25, weight: .bold))
                
                HStack(spacing: 10) {
                    selectionCell(imageName: "hand.thumbsup.fill", title: ReviewContent.Store.cafe.description, isSelected: selection == .cafe) {
                        self.selection = .cafe
                    }
                    
                    selectionCell(imageName: "hand.thumbsdown.fill", title: ReviewContent.Store.convenienceStore.description, isSelected: selection == .convenienceStore) {
                        self.selection = .convenienceStore
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

struct StoreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.StoreSelectionView(selection: .constant(nil))
    }
}
