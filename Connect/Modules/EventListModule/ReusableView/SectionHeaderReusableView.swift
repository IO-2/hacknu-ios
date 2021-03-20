//
//  SectionHeaderReusableView.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

final class SectionHeaderReusableView : UICollectionReusableView {
    
    @IBOutlet private weak var headerLabel : UILabel!
    
    public static var reuseIdentifier : String = "sectionHeader"
    
    public func set(header : String) -> () {
        self.headerLabel.text = header
    }
}
