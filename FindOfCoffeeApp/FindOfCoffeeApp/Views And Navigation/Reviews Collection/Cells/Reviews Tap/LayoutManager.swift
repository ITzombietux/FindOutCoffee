//
//  LayoutManager.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import UIKit

struct LayoutManager {
    
    enum DecorationKind {
        static let tasteBackground = "decoration-taste-background"
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            guard let sectionKind = ReviewListViewController.Section(rawValue: sectionIndex) else {
                fatalError("섹션이 정의되지 않음")
            }
            
            switch sectionKind {
            case .notice:
                return createNoticeSection()
            case .cafe:
                return createCafeSection()
            case .taste:
                return createTastesSection()
            case .convenienceStore:
                return createConvenienceStoreSection()
            }
        }
        
        layout.register(TasteBackgroundDecoration.self, forDecorationViewOfKind: DecorationKind.tasteBackground)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 45
        layout.configuration = configuration
        
        return layout
    }
    
    func createNoticeSection() -> NSCollectionLayoutSection {
        //sections, groups, items
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94), heightDimension: .estimated(280))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createCafeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSsctionHeaderSupplementary()]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createSsctionHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .absolute(60))
        let headerSupplementray = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: ReviewListViewController.SupplementaryElementKind.sectionHeader, alignment: .top)
        
        headerSupplementray.pinToVisibleBounds = true
        return headerSupplementray
    }
    
    func createConvenienceStoreSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSsctionHeaderSupplementary()]
        
        return section
    }
    
    func createTastesSection() -> NSCollectionLayoutSection {
        // sectionsm groups, items
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSsctionHeaderSupplementary()]
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: DecorationKind.tasteBackground)
        ]
        
        return section
    }
}
