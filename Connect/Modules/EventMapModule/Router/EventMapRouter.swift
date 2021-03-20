//
//  EventMapRouter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

protocol EventMapRouterProtocol {
    init(view : EventMapViewController)
}

final class EventMapRouter : EventMapRouterProtocol {
    
    private weak var view : EventMapViewController?
    
    init(view : EventMapViewController) {
        self.view = view
    }
}
