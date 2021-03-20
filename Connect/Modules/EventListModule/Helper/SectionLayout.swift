//
//  SectionLayout.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

final class SectionLayout : NSCollectionLayoutSection {
    
    public enum SectionType {
        case horizontal
        case list
    }
    
    public static func header() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        return .init(layoutSize: size, elementKind: SectionHeaderReusableView.reuseIdentifier, alignment: .top)
    }
    
    public static func horizontal() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets.leading = 4
        item.contentInsets.trailing = 4
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return group
    }
    
    public static func list() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets.leading = 4
        item.contentInsets.trailing = 4
        
        item.contentInsets.bottom = 8
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(112))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        return group
    }
    
    public convenience init(type : SectionType) {
        switch type {
            case .horizontal:
                self.init(group: SectionLayout.horizontal())
                self.orthogonalScrollingBehavior = .groupPaging
                
            case .list: self.init(group: SectionLayout.list())
        }
        
        self.contentInsets.leading = 12
        self.contentInsets.trailing = 12
        
        self.boundarySupplementaryItems = [SectionLayout.header()]
    }
}
