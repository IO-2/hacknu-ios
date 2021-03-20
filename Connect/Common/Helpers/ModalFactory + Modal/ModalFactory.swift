//
//  ModalFactory.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import SwiftEntryKit

final class ModalFactory {
    
    public enum ModalType {
        case bottom
    }
    
    private let type : ModalType
    
    private func bottomed() -> EKAttributes {
        var attributes = EKAttributes()
        
        attributes.screenBackground = .color(color: EKColor.black.with(alpha: 0.25))
        attributes.displayDuration = .infinity
        
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        attributes.position = .bottom
        
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        
        attributes.positionConstraints.safeArea = .overridden
        
        attributes.positionConstraints.size.width = .fill
        attributes.positionConstraints.size.height = .constant(value: 450)
        
        return attributes
    }
    
    public func display(view : Modal) -> () {
        view.prepare()
        
        switch self.type {
            case .bottom: SwiftEntryKit.display(entry: view, using: self.bottomed())
        }
    }
    
    required init(type : ModalType) {
        self.type = type
    }
}
