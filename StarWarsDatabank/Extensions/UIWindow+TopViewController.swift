//
//  UIWindow+TopViewController.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 26/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

extension UIWindow {
    func topViewController() -> UIViewController? {
        var controller = self.rootViewController
        while true {
            if let presented = controller?.presentedViewController {
                controller = presented
            } else if let nav = controller as? UINavigationController {
                controller = nav.visibleViewController
            } else {
                break
            }
        }
        return controller
    }
}
