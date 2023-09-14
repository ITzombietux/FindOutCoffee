//
//  DynamicWidthGrid.swift
//  
//
//  Created by 김혜지 on 2023/09/10.
//

import SwiftUI

struct DynamicWidthGrid<ElementView: View>: View {
    private let elementCount: Int
    private let elementView: (Int) -> ElementView
    
    public init(elementCount: Int, @ViewBuilder elementView: @escaping (Int) -> ElementView) {
        self.elementCount = elementCount
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
            ForEach(0..<self.elementCount, id: \.self) { index in
                self.elementView(index)
                    .padding([.horizontal, .vertical], 5)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if (abs(width - dimension.width) > geometry.size.width)
                        {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if index == self.elementCount - 1 {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { dimension in
                        let result = height
                        if index == self.elementCount - 1 {
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
        DynamicWidthGrid(elementCount: 10) { index in
            Text("index \(index)")
                .padding(.all, 5)
                .font(.body)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
    }
}
