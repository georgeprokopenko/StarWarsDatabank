//
//  RoutableViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class RoutableViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var router: Router!
}

extension RoutableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
