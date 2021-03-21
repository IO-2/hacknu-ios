//
//  CityPickerView.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol CityPickerViewProtocol : Modal {
    func reloadData() -> ()
}

final class CityPickerView : UIView, CityPickerViewProtocol {
    
    @IBOutlet private weak var cityPickerView: UIPickerView!
    
    @IBOutlet private weak var doneButton: UIButton!
    
    public var presenter : CityPickerPresenterProtocol!
    
    @IBAction private func doneButtonPressed(_ sender : UIButton) -> () {
        self.presenter.doneButtonPressed()
    }
    
    public func reloadData() -> () {
        self.cityPickerView.reloadAllComponents()
    }
    
    public func prepare() -> () {
        self.cityPickerView.delegate = self
        self.cityPickerView.dataSource = self
        
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 16
        
        self.doneButton.layer.cornerRadius = 16
        
        self.presenter.prepare()
    }
}

extension CityPickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.presenter.titleFor(row: row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter.didSelect(row: row)
    }
}
