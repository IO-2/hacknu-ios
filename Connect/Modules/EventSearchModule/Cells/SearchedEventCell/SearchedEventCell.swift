//
//  SearchedEventCell.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

final class SearchedEventCell : UITableViewCell, EventCellProtocol {
    
    @IBOutlet private weak var mainView : UIView!
    
    @IBOutlet private weak var eventNameLabel : UILabel!
    @IBOutlet private weak var eventDateLabel : UILabel!
    @IBOutlet private weak var eventAddressLabel : UILabel!
    
    public func set(name : String) -> () {
        self.eventNameLabel.text = name
    }
    
    public func set(date : Date) -> () {
        self.eventDateLabel.text = date.format(to: "dd MMMM, yyyy")
    }
    
    public func set(address : String) -> () {
        self.eventAddressLabel.text = address
    }
    
    override internal func awakeFromNib() -> () {
        super.awakeFromNib()
        
        self.mainView.layer.cornerRadius = 16
    }
}
