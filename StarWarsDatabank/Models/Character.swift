//
//  Character.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit
import RealmSwift

typealias CharacterDetails = (key: String, value: String)

enum Gender: String, Codable {
    case male
    case female
}

class Character: Object, Codable {
    @objc dynamic var name: String
    @objc dynamic var height: String
    @objc dynamic var mass: String
    @objc dynamic var hairColor: String?
    @objc dynamic var skinColor: String?
    @objc dynamic var birthYear: String
    @objc dynamic var gender: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case birthYear = "birth_year"
        case gender
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    var details: [CharacterDetails] {
        return [("Name", name),
                ("Height", height),
                ("Mass", mass),
                ("Hair color", hairColor ?? "n/a"),
                ("Skin color", skinColor ?? "n/a"),
                ("Birth year", birthYear),
                ("Gender", gender)]
    }
}

