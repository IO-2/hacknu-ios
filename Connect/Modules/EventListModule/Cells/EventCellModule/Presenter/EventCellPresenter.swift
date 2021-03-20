//
//  EventCellPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

protocol EventCellPresenterProtocol {
    func subscribeButtonPressed() -> ()
    
    init(view : EventCellProtocol)
}

final class EventCellPresenter : EventCellPresenterProtocol {
    
    private weak var view : EventCellProtocol?
    
    public func subscribeButtonPressed() -> () {
        
    }
    
    init(view : EventCellProtocol) {
        self.view = view
    }
}
