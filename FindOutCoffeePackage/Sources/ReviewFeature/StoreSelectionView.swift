//
//  StoreSelectionView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI

extension ReviewContentView {
    struct StoreSelectionView: View {
        private let selection: ReviewContent.Store?
        private let action: (ReviewContent.Store) -> Void
        
        init(selection: ReviewContent.Store?, action: @escaping (ReviewContent.Store) -> Void) {
            self.selection = selection
            self.action = action
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("이 음료 어디서 샀어요?")
                    .font(.system(size: 25, weight: .bold))
                
                Button {
                    action(.convenienceStore)
                } label: {
                    ZStack(alignment: .leading) {
                        if selection == .convenienceStore {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.blue)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                                .foregroundColor(.gray)
                        }
                        
                        Text("🏪 \(ReviewContent.Store.convenienceStore.description)")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(selection == .convenienceStore ? .white : .black)
                            .padding(.leading, 10)
                    }
                }
                .frame(height: 40)
                
                Button {
                    action(.cafe)
                } label: {
                    ZStack(alignment: .leading) {
                        if selection == .cafe {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.blue)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                                .foregroundColor(.gray)
                        }
                        
                        Text("☕️ \(ReviewContent.Store.cafe.description)")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(selection == .cafe ? .white : .black)
                            .padding(.leading, 10)
                    }
                }
                .frame(height: 40)
            }
        }
    }
}

struct StoreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.StoreSelectionView(selection: nil) { _ in
            
        }
    }
}
