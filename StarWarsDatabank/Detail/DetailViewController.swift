//
//  DetailViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

final class DetailViewController: RoutableViewController {
    var viewModel: DetailViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.object.name
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.object.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let details = viewModel.object.details[indexPath.row]
        cell.textLabel?.text = details.key
        cell.detailTextLabel?.text = details.value
        return cell
    }
}
