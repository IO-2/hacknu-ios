//
//  Event.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

final class Tag : Codable {
    public let id : Int
    public let text : String
}

final class Event : Codable, Equatable {
    
    public let id : Int
    
    public let name : String
    public let city : String
    public let description : String
    
    public let longitude : Double
    public let latitude : Double
    
    public let organizerEmail : String
    public let tags : [Tag]
    
    public var date : Date {
        return .init(timeIntervalSince1970: TimeInterval(self.unix))
    }
    
    private let unix : Int64
    
    public enum CodingKeys : String, CodingKey {
        case id
        case name
        case city
        case description
        case longitude
        case latitude
        case organizerEmail
        case tags
        case unix = "unixTime"
    }
    
    public static func == (lhs : Event, rhs : Event) -> Bool {
        return lhs.id == rhs.id
    }
}
