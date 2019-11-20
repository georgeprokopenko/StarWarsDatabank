//
//  Character.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

enum Gender: String, Codable {
    case male
    case female
}

class Character: Object {
    let name: String = ""
    let height: String = ""
    let mass: String = ""
    let hairColor: String = ""
    let skinColor: String = ""
    let birthYear: String = ""
    let gender: Gender = .male
}
