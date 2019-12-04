//
//  DefaultAlamofireManager.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 29/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAlamofireManager: Alamofire.SessionManager {
    static let managerWithTimeout: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 5
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
