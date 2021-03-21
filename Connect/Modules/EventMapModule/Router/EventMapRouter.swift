//
//  EventMapRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol EventMapRouterProtocol {
    func presentDetails(of event : Event) -> ()
    func prepare(for segue : UIStoryboardSegue) -> ()
    
    init(view : EventMapViewController)
}

final class EventMapRouter : EventMapRouterProtocol {
    
    private weak var view : EventMapViewController?
    
    public func presentDetails(of event : Event) -> () {
        let view = EventDetailBuilder.build(with: event)
        ModalFactory(type: .bottom).display(view: view)
    }
    
    public func prepare(for segue: UIStoryboardSegue) -> () {
        if segue.identifier == "showSearch" {
            guard let navController = segue.destination as? UINavigationController,
                  let view = navController.viewControllers.first as? EventSearchTableViewController
            else { return }
            
            EventSearchConfigurator.configure(view: view)
        }
    }
    
    init(view : EventMapViewController) {
        self.view = view
    }
}
