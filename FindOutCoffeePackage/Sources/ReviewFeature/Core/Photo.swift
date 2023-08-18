//
//  Photo.swift
//  
//
//  Created by 김혜지 on 2023/08/19.
//

import Foundation

public final class Photo: Identifiable {
    public let id: UUID
    private let max: Int
    private(set) var items: [Data]
    
    public init(max: Int = 3, items: [Data]) {
        self.id = UUID()
        self.max = max
        self.items = items
    }
    
    public func add(_ newItems: [Data]) {
        let totalItems = self.items + newItems
        guard totalItems.count <= 3 else {
            let validRange = (totalItems.count - 3)...(totalItems.count - 1)
            self.items = totalItems[validRange].map({$0})
            return
        }
        self.items = totalItems
    }
}

extension Photo: Equatable {
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}
