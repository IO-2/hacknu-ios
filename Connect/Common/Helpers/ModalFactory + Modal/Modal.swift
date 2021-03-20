//
//  Modal.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import SwiftEntryKit

protocol Modal : UIView {
    func prepare() -> ()
}

extension Modal {
    
    public func present(view : UIViewController) -> () {
        let window = UIApplication.shared.windows.filter{ $0.isKeyWindow }.first
        window?.rootViewController?.present(view, animated: true, completion: nil)
    }
    
    public func dismiss(completion: (() -> ())? = nil) -> () {
        SwiftEntryKit.dismiss(.displayed, with: completion)
    }
    
}
