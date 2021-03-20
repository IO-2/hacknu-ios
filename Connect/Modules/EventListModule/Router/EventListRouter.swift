//
//  EventListRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

protocol EventListRouterProtocol {
    func presentDetails(of event : Event) -> () 
    init(view : EventListCollectionViewController)
}

final class EventListRouter : EventListRouterProtocol {
    
    private weak var view : EventListCollectionViewController?
    
    public func presentDetails(of event : Event) -> () {
        let view = EventDetailBuilder.build(with: event)
        ModalFactory(type: .bottom).display(view: view)
    }
    
    init(view : EventListCollectionViewController) {
        self.view = view
    }
}
