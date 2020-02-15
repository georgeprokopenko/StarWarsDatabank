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
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func go(to screen: Screen, from: UIViewController? = nil) {
        var controller: UIViewController
        
        switch screen {
        case .search:
            controller = searchModule()
        case .detail(let character):
            controller = detailModule(character)
        }
        
        if UIApplication.shared.keyWindow != nil {
            from?.navigationController?.pushViewController(controller, animated: true)
        } else {
            configureWindow(with: controller)
        }
    }

// MARK: Private
    
    private func searchModule() -> SearchViewController {
        let searchModule = SearchViewController.instantiateFromStoryboard()
        searchModule.viewModel = SearchViewModel(serviceFactory: serviceFactory)
        searchModule.router = self
        return searchModule
    }

    private func detailModule(_ object: Character) -> DetailViewController {
        let detailModule = DetailViewController.instantiateFromStoryboard()
        detailModule.viewModel = DetailViewModel(character: object)
        detailModule.router = self
        return detailModule
    }
    
    private var window: UIWindow!
    private func configureWindow(with rootController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: rootController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
