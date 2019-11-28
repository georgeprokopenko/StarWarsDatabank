//
//  AppDelegate.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 19/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let router = Router(serviceFactory: ServiceFactory())
        router.go(to: .search)
        
        return true
    }
}

