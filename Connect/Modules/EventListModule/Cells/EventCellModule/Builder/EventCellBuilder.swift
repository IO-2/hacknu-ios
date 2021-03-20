//
//  EventCellBuilder.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

final class EventCellBuilder {
    
    public enum EventCellType : String {
        case upcoming = "UpcomingEventCell"
        case nearby = "NearbyEventCell"
    }
    
    public static func nib(for type : EventCellType) -> UINib {
        return .init(nibName: type.rawValue, bundle: nil)
    }
    
    public static func build(type : EventCellType) -> EventCell {
        let view = EventCellBuilder.nib(for: type).instantiate(withOwner: nil, options: nil)[0] as! EventCell
        let presenter = EventCellPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
    
}
