//
//  Router.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

enum Screen<T: Codable> {
    case search
    case detail(T)
}

class Router: NSObject {

    func go(to screen: Screen<Object>) {
        switch screen {
        case .search:
            goToSearchScreen()
        case .detail(let object):
            goToDetailScreen(object)
        }
    }
    
    private func goToSearchScreen() {
        
    }
    
    private func goToDetailScreen(_ object: Object) {
        
    }
}
