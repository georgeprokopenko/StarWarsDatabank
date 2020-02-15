//
//  SearchViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

final class SearchViewController: RoutableViewController<SearchViewModeling> {
    private enum Constants {
        static let cellIdentifier = CharacterCell.identifier
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.isLoading.addListener { [weak self] isLoading in
            isLoading ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
        }
        viewModel.mode.addListener { [weak self] _ in
            self?.reloadData()
        }
        viewModel.results.addListener { [weak self] _ in
            self?.reloadData()
        }
    }
    
    private func reloadData() {
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: Constants.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func search(for string: String) {
        viewModel.search(for: string)
    }
    
    private func showRecents() {
        viewModel.loadRecents()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.mode.value.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath) as? CharacterCell else { return UITableViewCell() }
        
        let character = viewModel.results.value[indexPath.row]
        cell.configure(title: character.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = viewModel.results.value[indexPath.row]
        viewModel.saveRecent(object)
        router.go(to: .detail(object), from: self)
    }

    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard viewModel.mode.value == .recents else { return nil }
        return [
            UITableViewRowAction(style: .destructive,
                                 title: "Delete") { [weak self] (action, indexPath) in
                                    if let object = self?.viewModel.results.value[indexPath.row] {
                                        self?.viewModel.removeRecent(object)
                                    }
            }]
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
        search(for: searchText)
    }
}
