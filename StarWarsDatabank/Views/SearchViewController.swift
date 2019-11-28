//
//  SearchViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

final class SearchViewController: RoutableViewController {
    
    private enum Constants {
        static let cellIdentifier = CharacterCell.identifier
    }
    
    private enum ViewMode: String {
        case none = "No data"
        case search = "Search"
        case recents = "Recents"
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var mode: ViewMode = .none
    private var networkService: NetworkService<Character>!
    private var databaseService: DatabaseService<Character>!
    private var results: [Character]? {
        didSet {
            if results == nil || results?.isEmpty ?? true {
                mode = .none
            }
        }
    }
    
    override func configure(serviceFactory: ServiceFactory) {
        networkService = serviceFactory.networkService()
        databaseService = serviceFactory.databaseService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showRecents()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: Constants.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func search(for string: String) {
        spinner.startAnimating()
        networkService.search(for: string) { [weak self] response, _ in
            self?.mode = .search
            self?.results = response?.results
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            self?.spinner.stopAnimating()
        }
    }
    
  
    private func showRecents() {
        mode = .recents
        results = databaseService.savedObjects()
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mode.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? CharacterCell,
            let character = results?[indexPath.row] {
            cell.configure(title: character.name)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let object = results?[indexPath.row] {
            databaseService.saveObject(object)
            router.go(to: .detail(object))
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard mode == .recents, let object = results?[indexPath.row] else { return nil }
        
        return [ UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            self?.results?.remove(at: indexPath.row)
            self?.databaseService.deleteObject(object)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.reloadData()
        } ]
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        showRecents()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ? showRecents() : search(for: searchText)
    }
}
