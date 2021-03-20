//
//  LocationLayer.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import MapboxGeocoder
import CoreLocation

protocol LocationLayerProtocol {
    var current : CLLocationCoordinate2D { get }
    
    func city(at coordinate : CLLocationCoordinate2D?, completion: @escaping (Result<String, NSError>) -> ()) -> ()
}

final class LocationLayer : LocationLayerProtocol {
    
    public static var shared : LocationLayerProtocol = LocationLayer()
    
    private var locationManager : CLLocationManager
    
    public var current: CLLocationCoordinate2D {
        return self.locationManager.location?.coordinate ?? .init()
    }
    
    public func city(at coordinate : CLLocationCoordinate2D?, completion: @escaping (Result<String, NSError>) -> ()) -> () {
        let options = ReverseGeocodeOptions(coordinate: coordinate ?? self.locationManager.location?.coordinate ?? .init())
        
        Geocoder.shared.geocode(options) { placemarks, attribution, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let placemark = placemarks?.first else { return }
            let city = placemark.administrativeRegion?.name ?? placemark.name
            
            completion(.success(city))
        }
    }
    
    private init() {
        self.locationManager = .init()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
}
