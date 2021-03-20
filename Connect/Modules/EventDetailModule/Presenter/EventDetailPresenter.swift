//
//  EventDetailPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol EventDetailPresenterProtocol {
    func configure(cell : EventDetailCellProtocol, at indexPath : IndexPath) -> ()
    func prepare() -> ()
    
    init(view : EventDetailViewProtocol, event : Event)
}

final class EventDetailPresenter : EventDetailPresenterProtocol {
    
    private weak var view : EventDetailViewProtocol?
    private var event : Event
    
    private func nameConfiguration(cell : EventDetailCellProtocol) -> () {
        cell.set(image: UIImage(systemName: "tag.circle"))
        cell.set(title: "Name")
        cell.set(description: self.event.name)
    }
    
    public func dateConfiguration(cell : EventDetailCellProtocol) -> () {
        cell.set(image: UIImage(systemName: "calendar.circle"))
        cell.set(title: "Date")
        cell.set(description: self.event.date.format(to: "dd MMMM, yyyy"))
    }
    
    public func addressConfiguration(cell : EventDetailCellProtocol) -> () {
        cell.set(image: UIImage(systemName: "mappin.circle"))
        cell.set(title: "Address")
        
        LocationLayer.shared.address(at: .init(latitude: self.event.latitude, longitude: self.event.longitude)) { result in
            switch result {
                case .success(let address): cell.set(description: address)
                case .failure(_): cell.set(description: "ERROR")
            }
        }
    }
    
    public func descriptionConfiguration(cell : EventDetailCellProtocol) -> () {
        cell.set(image: UIImage(systemName: "info.circle"))
        cell.set(title: "Description")
        cell.set(description: self.event.description)
    }
    
    public func emailConfiguration(cell : EventDetailCellProtocol) -> () {
        cell.set(image: UIImage(systemName: "envelope.circle"))
        cell.set(title: "Contact e-mail")
        cell.set(description: self.event.organizerEmail)
        cell.set(descriptionColor: .systemBlue)
    }
    
    public func configure(cell : EventDetailCellProtocol, at indexPath : IndexPath) -> () {
        switch indexPath.row {
            case 0: self.nameConfiguration(cell: cell)
            case 1: self.dateConfiguration(cell: cell)
            case 2: self.addressConfiguration(cell: cell)
            case 3: self.descriptionConfiguration(cell: cell)
            case 4: self.emailConfiguration(cell: cell)
            default: break
        }
    }
    
    public func prepare() -> () {
        
    }
    
    init(view: EventDetailViewProtocol, event : Event) {
        self.view = view
        self.event = event
    }
}
