//
//  UIViewController+Extension.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 26/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self {
        return instantiateController(storyboardName: name)
    }

    fileprivate class func instantiateController<T>(storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: String(describing: self)) as! T
        return controller
    }
}
