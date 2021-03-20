//
//  EventListRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

protocol EventListRouterProtocol {
    init(view : EventListCollectionViewController)
}

final class EventListRouter : EventListRouterProtocol {
    
    private weak var view : EventListCollectionViewController?
    
    init(view : EventListCollectionViewController) {
        self.view = view
    }
}
