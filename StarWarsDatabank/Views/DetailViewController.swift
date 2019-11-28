//
//  DetailViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

final class DetailViewController: RoutableViewController {
    var object: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = object.name
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Info"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let details = object.details[indexPath.row]
        cell.textLabel?.text = details.key
        cell.detailTextLabel?.text = details.value
        return cell
    }
}
