//
//  EventListBuilder.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

final class EventListBuilder {
    
    public static func build(_ coder : NSCoder) -> EventListCollectionViewController {
        let view = EventListCollectionViewController(coder: coder)!
        let router = EventListRouter(view: view)
        let presenter = EventListPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
