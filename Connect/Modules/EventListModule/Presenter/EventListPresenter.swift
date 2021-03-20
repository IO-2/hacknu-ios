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
    
    func viewDidLoad() -> ()
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol)
}

final class EventListPresenter : EventListPresenterProtocol {
    
    private weak var view : EventListCollectionViewControllerProtocol?
    private var router : EventListRouterProtocol
    
    private var dataSource : [Event] = .init()
    
    private var isLoading : Bool = false
    
    public func numberOfSections() -> Int {
        return 2
    }
    
    public func numberOfItems(in section: Int) -> Int {
        if self.isLoading {
            return 8
        }
        
        return self.dataSource.count
    }
    
    public func configure(cell: EventCellProtocol, at indexPath: IndexPath) -> () {
        
    }
    
    public func configure(header: SectionHeaderReusableView, at indexPath: IndexPath) -> () {
        header.set(header: indexPath.section == 0 ? "Upcoming" : "Nearby")
    }
    
    public func viewDidLoad() -> () {
        self.isLoading = true
        
        NetworkLayer.shared.retrieveEvents(at: .init(latitude: 55.75, longitude: 37.6)) { result in
            switch result {
                case .success(let events): print(events)
                case .failure(let error): print(error)
            }
        }
    }
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol) {
        self.view = view
        self.router = router
    }
}
