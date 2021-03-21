//
//  EventListCollectionViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

protocol EventListCollectionViewControllerProtocol : class {
    func reloadData() -> ()
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
        
        self.collectionView.register(UINib(nibName: "UpcomingEventCell", bundle: nil), forCellWithReuseIdentifier: "upcomingCell")
        self.collectionView.register(UINib(nibName: "NearbyEventCell", bundle: nil), forCellWithReuseIdentifier: "nearbyCell")
        
        self.collectionView.register(UINib(nibName: "SectionHeaderReusableView", bundle: nil),
                                     forSupplementaryViewOfKind: SectionHeaderReusableView.reuseIdentifier,
                                     withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
    }
    
    public func reloadData() -> () {
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve,animations: { self.collectionView.reloadData()})
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) -> () {
        self.presenter.prepare(for: segue)
    }
    
    override internal func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.configure()
        self.presenter.viewDidLoad()
    }
    
    override internal func numberOfSections(in collectionView : UICollectionView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    override internal func collectionView(_ collectionView : UICollectionView, numberOfItemsInSection section : Int) -> Int {
        return self.presenter.numberOfItems(in: section)
    }
    
    override internal func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = indexPath.section == 0 ? "upcomingCell" : "nearbyCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCell
        
        self.presenter.configure(cell: cell, at: indexPath)
        
        return cell
    }
    
    override internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                          at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier = SectionHeaderReusableView.reuseIdentifier
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        self.presenter.configure(header: view, at: indexPath)
        
        return view
    }
    
    override internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> () {
        self.presenter.didSelectItem(at: indexPath)
    }
    
}
