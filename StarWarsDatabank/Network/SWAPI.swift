//
//  SWAPI.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 28/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import Moya

fileprivate enum Constants {
    static let peopleBaseURL = "https://swapi.co/api/people/"
}

enum SWCharactersAPI {
    case search(String)
}

extension SWCharactersAPI: TargetType {

    var baseURL: URL {
        return URL(string: Constants.peopleBaseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let searchString):
            return .requestParameters(parameters: ["search": searchString],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
}
    
extension SWCharactersAPI: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
      switch self {
      case .search: return .returnCacheDataElseLoad
        }
    }
}
