//
//  EventSearchRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

protocol EventSearchRouterProtocol {
    func presentDetails(of event : Event) -> ()
    init(view : EventSearchTableViewController)
}

final class EventSearchRouter : EventSearchRouterProtocol {
    
    private weak var view : EventSearchTableViewController?
    
    public func presentDetails(of event : Event) -> () {
        let view = EventDetailBuilder.build(with: event)
        ModalFactory(type: .bottom).display(view: view)
    }
    
    init(view: EventSearchTableViewController) {
        self.view = view
    }
}
