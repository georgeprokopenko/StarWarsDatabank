//
//  Router.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

enum Screen {
    case search
    case detail(Character)
}

class Router: NSObject {
    private let serviceFactory: ServiceFactory!
    private var window: UIWindow!
    private lazy var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func go(to screen: Screen) {
        switch screen {
        case .search:
            goToSearchScreen()
        case .detail(let character):
            goToDetailScreen(character)
        }
    }

// MARK: Private
    
    private func goToSearchScreen() {
        let identifier = String(describing: SearchViewController.self)
        if let search = mainStoryboard.instantiateViewController(withIdentifier: identifier)
                                                                 as? SearchViewController {
            search.router = self
            search.configure(serviceFactory: serviceFactory)
            present(search, animated: true)
        }
    }

    private func goToDetailScreen(_ object: Character) {
        let identifier = String(describing: DetailViewController.self)
        if let detail = mainStoryboard.instantiateViewController(withIdentifier: identifier)
                                                                 as? DetailViewController {
            detail.router = self
            detail.configure(serviceFactory: serviceFactory)
            detail.object = object
            present(detail, animated: true)
        }
    }
    
    private func present(_ viewController: UIViewController, animated: Bool) {
        if let root = window?.topViewController() {
            if root.navigationController != nil {
                root.navigationController?.pushViewController(viewController, animated: true)
            } else {
                print("DEBUG: Router: no navigation controller")
                root.present(viewController, animated: true, completion: nil)
            }
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let navigation = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
    }
}
