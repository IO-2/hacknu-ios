//
//  EventDetailBuilder.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

final class EventDetailBuilder {
    
    public static func build(with event : Event) -> EventDetailView {
        let view = UINib(nibName: "EventDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EventDetailView
        let presenter = EventDetailPresenter(view: view, event: event)
        
        view.presenter = presenter
        
        return view
    }
}
