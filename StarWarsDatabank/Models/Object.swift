//
//  Object.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

enum EntityType: String, Codable {
    case character
    case planet
    case starship
    
    func localized() -> String {
        switch self {
        case .character: return "Character"
        case .planet: return "Planet"
        case .starship: return "Starship"
            //TODO: Make Localization
        }
    }
}

class Object: Codable {
    let id: Int
    let type: EntityType
}
