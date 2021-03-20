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
    
    func didSelectItem(at indexPath : IndexPath) -> ()
    
    func configure(cell : EventCellProtocol, at indexPath : IndexPath) -> ()
    func configure(header : SectionHeaderReusableView, at indexPath : IndexPath) -> ()
    
    func viewDidLoad() -> ()
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol)
}

final class EventListPresenter : EventListPresenterProtocol {
    
    private weak var view : EventListCollectionViewControllerProtocol?
    private var router : EventListRouterProtocol
    
    private var upcomingEvents : [Event] = .init()
    private var nearbyEvents : [Event] = .init()
    
    private var isLoading : Bool = false
    
    private func retrieveEvents(city : String) -> () {
        let group : DispatchGroup = .init()
        
        var occuredError : NSError?
        
        let lat = LocationLayer.shared.current.latitude
        let lon = LocationLayer.shared.current.longitude
        
        let userLocation = UserLocation(ascending: true, longitude: lon, latitude: lat)
        
        let nearbyRequest = EventRequest(city: city, query: nil, dateAscending: true, eventLocation: userLocation, tags: nil)
        let upcomingRequest = EventRequest(city: city, dateAscending: true)
        
        group.enter()
        NetworkLayer.shared.retrieveEvents(with: upcomingRequest) { result in
            switch result {
                case .success(let events): self.upcomingEvents = events
                case .failure(let error): occuredError = error
            }
            
            group.leave()
        }
        
        group.enter()
        NetworkLayer.shared.retrieveEvents(with: nearbyRequest) { result in
            switch result {
                case .success(let events): self.nearbyEvents = events
                case .failure(let error): occuredError = error
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            
            if let error = occuredError {
                print(error)
                return
            }
            
            self.view?.reloadData()
        }
        
    }
    
    public func numberOfSections() -> Int {
        return 2
    }
    
    public func numberOfItems(in section: Int) -> Int {
        if self.isLoading {
            return 8
        }
        
        return section == 0 ? self.upcomingEvents.count : self.nearbyEvents.count
    }
    
    public func didSelectItem(at indexPath : IndexPath) -> () {
        let event : Event = indexPath.section == 0 ? self.upcomingEvents[indexPath.item] : self.nearbyEvents[indexPath.item]
        self.router.presentDetails(of: event)
    }
    
    public func configure(cell: EventCellProtocol, at indexPath: IndexPath) -> () {
        if self.isLoading { return }
        
        let event : Event = indexPath.section == 0 ? self.upcomingEvents[indexPath.item] : self.nearbyEvents[indexPath.item]
        
        cell.set(name: event.name)
        cell.set(date: event.date)
        
        LocationLayer.shared.address(at: .init(latitude: event.latitude, longitude: event.longitude)) { result in
            switch result {
                case .success(let address): cell.set(address: address)
                case .failure(_): cell.set(address: "Somewhere")
            }
        }
    }
    
    public func configure(header: SectionHeaderReusableView, at indexPath: IndexPath) -> () {
        header.set(header: indexPath.section == 0 ? "Upcoming" : "Nearby")
    }
    
    public func viewDidLoad() -> () {
        self.isLoading = true
        
        LocationLayer.shared.city(at: LocationLayer.shared.current) { result in
            switch result {
                case .success(let city): self.retrieveEvents(city: city)
                case .failure(let error): print(error)
            }
        }
    }
    
    init(view : EventListCollectionViewControllerProtocol, router : EventListRouterProtocol) {
        self.view = view
        self.router = router
    }
}
