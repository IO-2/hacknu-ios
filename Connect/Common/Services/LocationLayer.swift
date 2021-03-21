//
//  LocationLayer.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import CoreLocation

protocol LocationLayerProtocol {
    var current : CLLocationCoordinate2D { get }
    
    func address(at coordinate : CLLocationCoordinate2D, completion: @escaping (Result<String, NSError>) -> ()) -> ()
    func city(at coordinate : CLLocationCoordinate2D?, completion: @escaping (Result<String, NSError>) -> ()) -> ()
}

final class LocationLayer : LocationLayerProtocol {
    
    public static var shared : LocationLayerProtocol = LocationLayer()
    
    private var locationManager : CLLocationManager
    
    public var current: CLLocationCoordinate2D {
        return .init(latitude: 34.052235, longitude: -118.243683)//self.locationManager.location?.coordinate ?? .init()
    }
    
    public func address(at coordinate : CLLocationCoordinate2D, completion: @escaping (Result<String, NSError>) -> ()) -> () {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: .init(identifier: "en-EN")) { placemarks, error in
            if let placemarks = placemarks {
                for placemark in placemarks {
                    if let address = placemark.name {
                        completion(.success(address))
                    }
                }
            }
        }
    }
    
    public func city(at coordinate : CLLocationCoordinate2D?, completion: @escaping (Result<String, NSError>) -> ()) -> () {
        let lat = coordinate?.latitude ?? self.locationManager.location?.coordinate.latitude ?? 0.0
        let lon = coordinate?.longitude ?? self.locationManager.location?.coordinate.longitude ?? 0.0
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: .init(identifier: "en-EN")) { placemarks, error in
            if let placemarks = placemarks {
                for placemark in placemarks {
                    if let city = placemark.locality {
                        completion(.success(city))
                    }
                }
            }
        }
    }
    
    private init() {
        self.locationManager = .init()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
}
