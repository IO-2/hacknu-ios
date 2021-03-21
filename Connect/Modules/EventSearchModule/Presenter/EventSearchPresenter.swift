//
//  EventSearchPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

protocol EventSearchPresenterProtocol {
    func cityButtonPressed() -> ()
    
    func query(for name : String) -> ()
    
    func numberOfEvents() -> Int
    
    func didSelectEvent(at indexPath : IndexPath) -> ()
    func configure(eventCell : EventCellProtocol, at indexPath : IndexPath) -> ()
    
    func numberOfTags() -> Int
    
    func didSelectTag(at indexPath : IndexPath) -> ()
    func configure(tagCell : TagCell, at indexPath : IndexPath) -> ()
    
    func viewDidLoad() -> ()
    
    init(view : EventSearchTableViewControllerProtocol, router : EventSearchRouterProtocol)
}

final class EventSearchPresenter : EventSearchPresenterProtocol {
    
    private weak var view : EventSearchTableViewControllerProtocol?
    private var router : EventSearchRouterProtocol
    
    private var pickedCity : String = "" {
        didSet {
            self.view?.set(city: pickedCity)
        }
    }
    
    private var cities : [String] = .init()
    
    private var pickedTags : [Tag] = .init()
    private var tags : [Tag] = .init()
    
    private var events : [Event] = .init()
    
    public func cityButtonPressed() -> () {
        self.router.presentCityPicker(delegate: self)
    }
    
    public func query(for name: String) -> () {
        if name.isEmpty {
            self.events = .init()
            self.view?.reloadEvents()
            
            return
        }
        
        var intTags : [Int] = .init()
        
        for tag in self.pickedTags {
            intTags.append(tag.id)
        }
        
        let request = EventRequest(city: self.pickedCity, query: name, dateAscending: true, eventLocation: nil, tags: intTags)
        
        NetworkLayer.shared.retrieveEvents(with: request) { result in
            switch result {
                case .success(let events):
                    self.events = events
                    self.view?.reloadEvents()
                
                case .failure(let error): print(error)
            }
        }
    }
    
    public func numberOfEvents() -> Int {
        return self.events.count
    }
    
    public func didSelectEvent(at indexPath: IndexPath) {
        let event = self.events[indexPath.row]
        self.router.presentDetails(of: event)
    }
    
    public func configure(eventCell: EventCellProtocol, at indexPath: IndexPath) {
        let event = self.events[indexPath.row]
        
        eventCell.set(name: event.name)
        eventCell.set(date: event.date)
        
        LocationLayer.shared.address(at: .init(latitude: event.latitude, longitude: event.longitude)) { result in
            switch result {
                case .success(let address): eventCell.set(address: address)
                case .failure(_): eventCell.set(address: "ERROR")
            }
        }
    }
    
    public func numberOfTags() -> Int {
        return self.tags.count
    }
    
    public func didSelectTag(at indexPath: IndexPath) -> () {
        let tag = self.tags[indexPath.item]
        
        if self.pickedTags.contains(tag) {
            self.pickedTags.removeAll { $0 == tag }
            self.view?.reloadTags()
            return
        }
        
        self.pickedTags.append(tag)
        self.view?.reloadTags()
    }
    
    public func configure(tagCell: TagCell, at indexPath: IndexPath) {
        let tag = self.tags[indexPath.item]
        
        tagCell.set(tag: tag.text)
        tagCell.set(picked: self.pickedTags.contains(tag))
    }
    
    public func viewDidLoad() -> () {
        
        NetworkLayer.shared.retrieveTags { result in
            switch result {
                case .success(let tags):
                    self.tags = tags
                    self.view?.reloadTags()
                case .failure(let error): print(error)
            }
        }
        
        LocationLayer.shared.city(at: LocationLayer.shared.current) { result in
            switch result {
                case .success(let city): self.pickedCity = city
                case .failure(let error): print(error)
            }
        }
        
    }
    
    init(view: EventSearchTableViewControllerProtocol, router: EventSearchRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension EventSearchPresenter : CityPickerDelegate {
    
    public func didPick(city: String) -> () {
        self.pickedCity = city
    }
    
}
