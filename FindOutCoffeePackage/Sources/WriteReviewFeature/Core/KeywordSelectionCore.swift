//
//  KeywordSelectionCore.swift
//  
//
//  Created by Joy on 2023/09/14.
//

import ComposableArchitecture

public struct KeywordSelection: Reducer {
    public struct State: Equatable {
        public var priceKeywords: [String]
        public var tasteKeywords: [String]
        public var selectedPriceKeywordIndex: Int?
        public var selectedTasteKeywordIndex: Int?
        public var selectedKeywords: [String] {
            guard let selectedPriceKeywordIndex = self.selectedPriceKeywordIndex,
                  let selectedTasteKeywordIndex = self.selectedTasteKeywordIndex
            else { return [] }
            return [self.priceKeywords[selectedPriceKeywordIndex], self.tasteKeywords[selectedTasteKeywordIndex]]
        }
        
        public init(priceKeywords: [String] = [], tasteKeywords: [String] = [], selectedPriceKeywordIndex: Int? = nil, selectedTasteKeywordIndex: Int? = nil) {
            self.priceKeywords = priceKeywords
            self.tasteKeywords = tasteKeywords
            self.selectedPriceKeywordIndex = selectedPriceKeywordIndex
            self.selectedTasteKeywordIndex = selectedTasteKeywordIndex
        }
    }
    
    public enum Action {
        case load
        case selectPriceKeyword(Int)
        case selectTasteKeyword(Int)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .load:
            state.priceKeywords = []
            state.tasteKeywords = []
            return .none
            
        case let .selectPriceKeyword(index):
            state.selectedPriceKeywordIndex = index
            return .none
            
        case let .selectTasteKeyword(index):
            state.selectedTasteKeywordIndex = index
            return .none
        }
    }
}
