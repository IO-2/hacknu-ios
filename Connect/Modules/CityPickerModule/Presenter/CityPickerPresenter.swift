//
//  CityPickerPresenter.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation

protocol CityPickerDelegate {
    func didPick(city : String) -> ()
}

protocol CityPickerPresenterProtocol {
    func doneButtonPressed() -> ()
    
    func numberOfRows() -> Int
    func titleFor(row : Int) -> String
    func didSelect(row : Int) -> ()
    
    func prepare() -> ()
    
    init(view : CityPickerView, delegate : CityPickerDelegate?)
}

final class CityPickerPresenter : CityPickerPresenterProtocol {
    
    private weak var view : CityPickerViewProtocol?
    
    private var pickedCity : String = ""
    private var cities : [String] = .init()
    
    private var delegate : CityPickerDelegate?
    
    public func doneButtonPressed() -> () {
        self.delegate?.didPick(city: self.pickedCity)
        self.view?.dismiss()
    }
    
    public func numberOfRows() -> Int {
        return self.cities.count
    }
    
    public func titleFor(row : Int) -> String {
        return self.cities[row]
    }
    
    public func didSelect(row : Int) -> () {
        self.pickedCity = self.cities[row]
    }
    
    public func prepare() -> () {
        NetworkLayer.shared.retrieveCities { result in
            switch result {
                case .success(let cities):
                    self.cities = cities
                    self.view?.reloadData()
                    
                case .failure(let error): print(error)
            }
        }
    }
    
    init(view: CityPickerView, delegate : CityPickerDelegate?) {
        self.view = view
        self.delegate = delegate
    }
}
