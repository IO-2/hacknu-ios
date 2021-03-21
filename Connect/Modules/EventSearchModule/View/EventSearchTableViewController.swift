//
//  EventSearchTableViewController.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import UIKit

protocol EventSearchTableViewControllerProtocol : class {
    func set(city : String) -> ()
    
    func reloadEvents() -> ()
    func reloadTags() -> ()
}

final class EventSearchTableViewController : UITableViewController, EventSearchTableViewControllerProtocol {
        
    @IBOutlet private weak var tagsCollectionView : UICollectionView!
    @IBOutlet private weak var cityBarButtonItem : UIBarButtonItem!
    
    private let searchController : UISearchController = .init()
    
    public var presenter : EventSearchPresenterProtocol!
    
    @IBAction private func cityButtonPressed(_ sender : UIBarButtonItem) -> () {
        
    }
    
    @objc private func forceEndEditing() -> () {
        if self.searchController.searchBar.text!.isEmpty {
            self.searchController.isActive = false
        } else {
            self.searchController.searchBar.resignFirstResponder()
        }
    }
    
    private func configure() -> () {
        self.tagsCollectionView.delegate = self
        self.tagsCollectionView.dataSource = self
        
        self.searchController.searchResultsUpdater = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.searchController.searchBar.placeholder = "Type event name..."
        
        self.tableView.register(UINib(nibName: "SearchedEventCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = self.searchController
        
        self.definesPresentationContext = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forceEndEditing))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    public func set(city : String) -> () {
        self.cityBarButtonItem.title = city
    }
    
    public func reloadEvents() -> () {
        self.tableView.reloadData()
    }
    
    public func reloadTags() {
        self.tagsCollectionView.reloadData()
    }
    
    override internal func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.configure()
        self.presenter.viewDidLoad()
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfEvents()
    }
    
    override internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! SearchedEventCell
        self.presenter.configure(eventCell: cell, at: indexPath)
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> () {
        self.presenter.didSelectEvent(at: indexPath)
        self.forceEndEditing()
    }
}

extension EventSearchTableViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfTags()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagCell
        self.presenter.configure(tagCell: cell, at: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> () {
        self.presenter.didSelectTag(at: indexPath)
    }
}

extension EventSearchTableViewController : UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) -> () {
        let text = searchController.searchBar.text!
        self.presenter.query(for: text)
    }
    
}
