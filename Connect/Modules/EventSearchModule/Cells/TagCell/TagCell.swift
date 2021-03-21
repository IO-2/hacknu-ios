//
//  TagCell.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

final class TagCell : UICollectionViewCell {
    
    @IBOutlet private weak var tagLabel : UILabel!
    
    public func set(tag : String) -> () {
        self.tagLabel.text = "#" + tag
    }
    
    public func set(picked : Bool) -> () {
        self.contentView.backgroundColor = picked ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.5)
    }
    
    override internal func awakeFromNib() -> () {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
}
