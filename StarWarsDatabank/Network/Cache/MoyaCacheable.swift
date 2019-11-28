//
//  MoyaCacheable.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 28/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}
