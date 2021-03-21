//
//  EventListRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

protocol EventListRouterProtocol {
    func presentDetails(of event : Event) -> ()
    func prepare(for segue : UIStoryboardSegue) -> ()
    
    init(view : EventListCollectionViewController)
}

final class EventListRouter : EventListRouterProtocol {
    
    private weak var view : EventListCollectionViewController?
    
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
    
    init(view : EventListCollectionViewController) {
        self.view = view
    }
}
