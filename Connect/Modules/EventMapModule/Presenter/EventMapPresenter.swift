//
//  EventMapPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit
import Mapbox

protocol EventMapPresenterProtocol {
    func didSelect(annotation: MGLAnnotationView) -> ()
    func regionDidChange(mapView : MGLMapView) -> ()
    
    func prepare(for segue : UIStoryboardSegue) -> ()
    
    init(view : EventMapViewControllerProtocol, router : EventMapRouterProtocol)
}

final class EventMapPresenter : EventMapPresenterProtocol {
    
    private weak var view : EventMapViewControllerProtocol?
    private var router : EventMapRouterProtocol
    
    private var events : [Event] = .init() {
        didSet {
            for event in self.events {
                let point = MGLPointAnnotation()
                
                point.coordinate = .init(latitude: event.latitude, longitude: event.longitude)
                point.title = event.name
                point.subtitle = event.tags.first!.text
                
                self.view?.add(annotation: point)
            }
        }
    }
    
    public func didSelect(annotation: MGLAnnotationView) -> () {
        guard let lat = annotation.annotation?.coordinate.latitude,
              let lon = annotation.annotation?.coordinate.longitude
        else { return }
        
        for event in self.events {
            if event.latitude == lat && event.longitude == lon {
                self.router.presentDetails(of: event)
                break
            }
        }
    }
    
    public func regionDidChange(mapView: MGLMapView) -> () {
        LocationLayer.shared.city(at: mapView.camera.centerCoordinate) { result in
            switch result {
                case .success(let city):
                    let request = EventRequest(city: city, dateAscending: true)
                    
                    NetworkLayer.shared.retrieveEvents(with: request) { result in
                        switch result {
                            case .success(let events): self.events = events
                            case .failure(let error): print(error)
                        }
                    }
                case .failure(let error): print(error)
            }
        }
    }
    
    public func prepare(for segue: UIStoryboardSegue) -> () {
        self.router.prepare(for: segue)
    }
    
    init(view: EventMapViewControllerProtocol, router: EventMapRouterProtocol) {
        self.view = view
        self.router = router
    }
}
