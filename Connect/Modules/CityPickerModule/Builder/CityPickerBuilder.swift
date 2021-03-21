//
//  CityPickerBuilder.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

final class CityPickerBuilder {
    
    public static func build(with delegate : CityPickerDelegate?) -> CityPickerView {
        let view = UINib(nibName: "CityPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CityPickerView
        let presenter = CityPickerPresenter(view: view, delegate: delegate)
        
        view.presenter = presenter
        
        return view
    }
}
