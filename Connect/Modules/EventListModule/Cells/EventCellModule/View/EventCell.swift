//
//  EventCell.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

protocol EventCellProtocol : class {
    func set(name : String) -> ()
    func set(date : String) -> ()
    func set(address : String) -> ()
}

final class EventCell : UICollectionViewCell, EventCellProtocol {
    
    @IBOutlet private weak var eventNameLabel : UILabel!
    @IBOutlet private weak var eventDateLabel : UILabel!
    @IBOutlet private weak var eventAddressLabel : UILabel!
    
    @IBOutlet private weak var subscribeButton : UIButton!
    
    public var presenter : EventCellPresenterProtocol!
    
    @IBAction private func subscribeButtonPressed(_ sender : Any) -> () {
        self.presenter.subscribeButtonPressed()
    }
    
    public func set(name : String) -> () {
        self.eventNameLabel.text = name
    }
    
    public func set(date : String) -> () {
        self.eventDateLabel.text = date
    }
    
    public func set(address : String) -> () {
        self.eventAddressLabel.text = address
    }
    
    override internal func awakeFromNib() -> () {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 16
        self.subscribeButton.layer.cornerRadius = 8
    }
}
