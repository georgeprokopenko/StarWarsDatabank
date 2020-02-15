//
//  RoutableViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class RoutableViewController<T>: UIViewController, UIScrollViewDelegate {
    var viewModel: T!
    var router: Router!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
