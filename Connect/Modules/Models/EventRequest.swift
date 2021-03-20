//
//  EventRequest.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

struct UserLocation : Codable {
    private let ascending : Bool
    private let longitude : Double
    private let latitude : Double
    
    init(ascending : Bool, longitude : Double, latitude : Double) {
        self.ascending = ascending
        self.longitude = longitude
        self.latitude = latitude
    }
}

struct EventRequest : Codable {
    private let city : String
    private let query : String?
    
    private let dateAscending : Bool
    
    private let userLocation : UserLocation?
    private let tags : [Int]?
    
    init(city : String, query : String? = nil, dateAscending : Bool,
         eventLocation : UserLocation? = nil, tags : [Int]? = nil) {
        
        self.city = city
        self.query = query
        self.dateAscending = dateAscending
        self.userLocation = eventLocation
        self.tags = tags
    }
}
