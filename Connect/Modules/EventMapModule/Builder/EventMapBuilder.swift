//
//  EventMapBuilder.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

final class EventMapBuilder {
    
    public static func build(_ coder : NSCoder) -> EventMapViewController {
        let view = EventMapViewController(coder: coder)!
        let router = EventMapRouter(view: view)
        let presenter = EventMapPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
