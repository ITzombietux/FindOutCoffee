//
//  DynamicWidthGrid.swift
//  
//
//  Created by 김혜지 on 2023/09/10.
//

import SwiftUI

struct DynamicWidthGrid<ElementView: View>: View {
    @State private var elements: [String]
    private let elementView: (String) -> ElementView
    
    public init(elements: [String], @ViewBuilder elementView: @escaping (String) -> ElementView) {
        self.elements = elements
        self.elementView = elementView
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
                    .padding([.horizontal, .vertical], 5)
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
}

struct FlexibleGrid_Previews: PreviewProvider {
    static var previews: some View {
        DynamicWidthGrid(elements: ["하나", "두우우울", "셋", "네에에에에엣", "다아서엇", "여어어어어섯", "일곱", "여더어어얿"]) { title in
            Text(title)
                .padding(.all, 5)
                .font(.body)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
    }
}
