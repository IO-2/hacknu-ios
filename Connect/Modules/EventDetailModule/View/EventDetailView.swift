//
//  EventDetailView.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol EventDetailViewProtocol : Modal { }

final class EventDetailView : UIView, EventDetailViewProtocol {
    
    @IBOutlet private weak var titleLabel : UILabel!
    
    @IBOutlet private weak var tableView : UITableView!
    
    @IBOutlet private weak var subscribeButton : UIButton!
    
    public var presenter : EventDetailPresenterProtocol!
    
    public func prepare() -> () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "EventDetailCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 16
        
        self.subscribeButton.layer.cornerRadius = 16
        
        self.presenter.prepare()
    }
    
}

extension EventDetailView : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventDetailCell
        self.presenter.configure(cell: cell, at: indexPath)
        return cell
    }
    
}
