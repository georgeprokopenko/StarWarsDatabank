//
//  Debounce.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 04/12/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

public func debounce<T>(
    delay: DispatchTimeInterval,
    queue: DispatchQueue = .main,
    action: @escaping ((T) -> Void)) -> (T) -> Void {
    
    var currentWorkItem: DispatchWorkItem?
    return { parameter in
        currentWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            action(parameter)
        }
        currentWorkItem = workItem
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
}
