//
//  SelectionCell.swift
//  
//
//  Created by 김혜지 on 2023/08/16.
//

import SwiftUI

import DesignSystem

struct SelectionCell: View {
    private let title: String
    private let isSelected: Bool
    private let action: () -> Void
    
    init(title: String, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack(alignment: .leading) {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.mainColor)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundColor(.gray)
                }
                
                Text(title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                    .padding(.leading, 10)
            }
        }
        .frame(height: 40)
    }
}

struct SelectionCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectionCell(title: "SelectionCell", isSelected: false) {
            
        }
    }
}
