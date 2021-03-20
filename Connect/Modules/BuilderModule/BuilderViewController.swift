//
//  BuilderViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import UIKit

final class BuilderViewController : UIViewController {
    
    @IBSegueAction private func buildEventList(_ coder : NSCoder) -> EventListCollectionViewController {
        return EventListBuilder.build(coder)
    }
    
}
