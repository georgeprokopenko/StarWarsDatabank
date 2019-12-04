//
//  DetailViewModel.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 05/12/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

protocol DetailViewModeling {
    var object: Character! { get }
    var headerTitle: String { get }
}

final class DetailViewModel: DetailViewModeling {
    private(set) var object: Character!
    private(set) var headerTitle = "Info"
    
    init(character: Character) {
        self.object = character
    }
}
