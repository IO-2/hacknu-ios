//
//  EventMapViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit
import Mapbox

final class EventMapViewController : UIViewController {
    
    @IBOutlet private weak var mapView : MGLMapView!
    
    @IBOutlet private weak var searchButton : UIButton!
    
    @IBAction private func searchButtonPressed(_ sender : UIButton) -> () {
        
    }
    
    private func checkMapStyle() -> () {
        switch self.traitCollection.userInterfaceStyle {
            case .dark: self.mapView.styleURL = MGLStyle.darkStyleURL
            default: self.mapView.styleURL = MGLStyle.lightStyleURL
        }
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
        
        self.mapView.userTrackingMode = .followWithHeading
        self.mapView.minimumZoomLevel = 1
        
        self.checkMapStyle()
    }
}
