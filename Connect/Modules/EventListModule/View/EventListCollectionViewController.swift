//
//  EventListCollectionViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

protocol EventListCollectionViewControllerProtocol : class {
    
}

final class EventListCollectionViewController : UICollectionViewController, EventListCollectionViewControllerProtocol {
    
    public var presenter : EventListPresenterProtocol!
    
    private func buildLayout() -> UICollectionViewCompositionalLayout {
        return .init { section, _ -> NSCollectionLayoutSection? in
            if section == 0 {
                return SectionLayout(type: .horizontal)
            }
            
            return SectionLayout(type: .list)
        }
    }
    
    private func configure() -> () {
        self.collectionView.collectionViewLayout = self.buildLayout()
        
        self.collectionView.register(EventCellBuilder.nib(for: .upcoming), forCellWithReuseIdentifier: "upcomingCell")
        self.collectionView.register(EventCellBuilder.nib(for: .nearby), forCellWithReuseIdentifier: "nearbyCell")
        
        self.collectionView.register(UINib(nibName: "SectionHeaderReusableView", bundle: nil),
                                     forSupplementaryViewOfKind: SectionHeaderReusableView.reuseIdentifier,
                                     withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
    }
    
    override internal func viewDidLoad() -> () {
        super.viewDidLoad()
        self.configure()
    }
    
    override internal func numberOfSections(in collectionView : UICollectionView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    override internal func collectionView(_ collectionView : UICollectionView, numberOfItemsInSection section : Int) -> Int {
        return self.presenter.numberOfItems(in: section)
    }
    
    override internal func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = indexPath.section == 0 ? "upcomingCell" : "nearbyCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    override internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                          at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier = SectionHeaderReusableView.reuseIdentifier
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        self.presenter.configure(header: view, at: indexPath)
        
        return view
    }
}
