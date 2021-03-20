//
//  EventListPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

protocol EventListPresenterProtocol {
    func numberOfSections() -> Int
    func numberOfItems(in section : Int) -> Int
    
    func configure(cell : EventCellProtocol, at indexPath : IndexPath) -> ()
    func configure(header : SectionHeaderReusableView, at indexPath : IndexPath) -> ()
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol)
}

final class EventListPresenter : EventListPresenterProtocol {
    
    private weak var view : EventListCollectionViewControllerProtocol?
    private var router : EventListRouterProtocol
    
    private var isLoading : Bool = false
    
    public func numberOfSections() -> Int {
        return 2
    }
    
    public func numberOfItems(in section: Int) -> Int {
        if self.isLoading {
            return 8
        }
        
        return 8
    }
    
    public func configure(cell: EventCellProtocol, at indexPath: IndexPath) -> () {
        
    }
    
    public func configure(header: SectionHeaderReusableView, at indexPath: IndexPath) -> () {
        header.set(header: indexPath.section == 0 ? "Upcoming" : "Nearby")
    }
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol) {
        self.view = view
        self.router = router
    }
}
