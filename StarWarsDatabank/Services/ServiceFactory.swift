//
//  ServiceFactory.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 26/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import RealmSwift

class ServiceFactory {
    func networkService<T: Codable>() -> NetworkService<T> {
        return NetworkService<T>()
    }
    
    func databaseService<T: Object>() -> DatabaseService<T> {
        return DatabaseService<T>()
    }
}
