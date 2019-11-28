//
//  NetworkService.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 21/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

class NetworkService<T: Codable> {
    let provider = NetworkProvider<SWCharactersAPI>()
    
    func search(for text: String, completion: @escaping SWAPICharactersResponseBlock<T>) {
        provider.request(.search(text), responseType: T.self) { response, error in
            completion(response, error)
        }
    }
}
