//
//  EventMapViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit
import Mapbox

protocol EventMapViewControllerProtocol : class {
    func add(annotation : MGLAnnotation) -> ()
}

final class EventMapViewController : UIViewController, EventMapViewControllerProtocol {
    
    @IBOutlet private weak var mapView : MGLMapView!
    
    @IBOutlet private weak var searchButton : UIButton!
    
    public var presenter : EventMapPresenterProtocol!
    
    private func checkMapStyle() -> () {
        switch self.traitCollection.userInterfaceStyle {
            case .dark: self.mapView.styleURL = MGLStyle.darkStyleURL
            default: self.mapView.styleURL = MGLStyle.lightStyleURL
        }
    }
    
    public func add(annotation: MGLAnnotation) -> () {
        if let annotations = self.mapView.annotations {
            for ann in annotations {
                if ann.coordinate.latitude == annotation.coordinate.latitude &&
                    ann.coordinate.longitude == annotation.coordinate.longitude {
                    return
                }
            }
        }
        
        self.mapView.addAnnotation(annotation)
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) -> () {
        self.presenter.prepare(for: segue)
    }
    
    override internal func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) -> () {
        super.traitCollectionDidChange(previousTraitCollection)
        self.checkMapStyle()
    }
    
    override internal func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.searchButton.layer.cornerRadius = 16
        
        self.searchButton.layer.shadowColor = UIColor.black.cgColor
        self.searchButton.layer.shadowOpacity = 0.1
        self.searchButton.layer.shadowOffset = .zero
        self.searchButton.layer.shadowRadius = 8
        
        self.mapView.compassViewPosition = .topLeft
        
        self.mapView.userTrackingMode = .followWithHeading
        self.mapView.minimumZoomLevel = 1
        
        self.mapView.delegate = self
        
        self.checkMapStyle()
    }
}

extension EventMapViewController : MGLMapViewDelegate {
    
    public func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) -> () {
        self.presenter.regionDidChange(mapView: mapView)
    }
    
    public func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else { return nil }
        
        guard let subtitle = annotation.subtitle,
              let imageName = subtitle
        else { return nil }
        
        let reuseIdentifier = imageName
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = EventAnnotationView(reuseIdentifier: reuseIdentifier, image: UIImage(named: imageName))
            annotationView?.bounds = .init(origin: .zero, size: CGSize(width: 32, height: 32))
        }
        
        return annotationView
    }
    
    public func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) -> () {
        self.presenter.didSelect(annotation: annotationView)
    }
}
