//
//  EventDetailCell.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol EventDetailCellProtocol {
    func set(image : UIImage?) -> ()
    func set(title : String) -> ()
    func set(description : String) -> ()
    func set(descriptionColor : UIColor) -> ()
}

final class EventDetailCell : UITableViewCell, EventDetailCellProtocol {
    
    @IBOutlet private weak var typeImageView: UIImageView!
    
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    public func set(image : UIImage?) -> () {
        self.typeImageView.image = image
    }
    
    public func set(title : String) -> () {
        self.typeLabel.text = title
    }
    
    public func set(description : String) -> () {
        self.descriptionLabel.text = description
    }
    
    public func set(descriptionColor : UIColor) -> () {
        self.descriptionLabel.textColor = descriptionColor
    }
}
