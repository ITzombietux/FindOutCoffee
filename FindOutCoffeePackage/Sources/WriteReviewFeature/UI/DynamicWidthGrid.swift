//
//  DynamicWidthGrid.swift
//  
//
//  Created by 김혜지 on 2023/09/10.
//

import SwiftUI

struct DynamicWidthGrid: View {
    @State private var elements: [String]
    
    public init(elements: [String]) {
        self.elements = elements
    }

    var body: some View {
        GeometryReader { geometry in
            self.contentView(in: geometry)
        }
    }

    private func contentView(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.elements, id: \.self) { element in
                self.elementView(element)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if (abs(width - dimension.width) > geometry.size.width)
                        {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if element == self.elements.last! {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { dimension in
                        let result = height
                        if element == self.elements.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
    }

    private func elementView(_ element: String) -> some View {
        Text(element)
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}

struct FlexibleGrid_Previews: PreviewProvider {
    static var previews: some View {
        DynamicWidthGrid(elements: ["하나", "두우우울", "셋", "네에에에에엣", "다아서엇", "여어어어어섯", "일곱", "여더어어얿"])
    }
}
