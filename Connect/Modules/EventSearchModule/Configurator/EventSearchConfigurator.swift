//
//  EventSearchConfigurator.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

final class EventSearchConfigurator {
    
    public static func configure(view : EventSearchTableViewController) -> () {
        let router = EventSearchRouter(view: view)
        let presenter = EventSearchPresenter(view: view, router: router)
        
        view.presenter = presenter
    }
    
}
