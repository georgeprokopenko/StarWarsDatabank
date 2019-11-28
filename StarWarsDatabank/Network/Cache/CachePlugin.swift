//
//  CachePlugin.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 28/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import Moya

final class CachePlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    if let moyaCachableProtocol = target as? MoyaCacheable {
      var cachableRequest = request
      cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
      return cachableRequest
    }
    return request
  }
}
