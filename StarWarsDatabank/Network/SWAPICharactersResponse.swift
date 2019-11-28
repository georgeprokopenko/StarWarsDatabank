//
//  SWAPICharactersResponse.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 28/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

struct SWAPICharactersResponse<T>: Codable where T: Codable {
    var results: [T]?
}

typealias SWAPICharactersResponseBlock<T> = ((SWAPICharactersResponse<T>?, SWError?) -> ()) where T: Codable
