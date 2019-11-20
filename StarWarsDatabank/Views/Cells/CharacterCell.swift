//
//  CharacterCell.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit



class CharacterCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = nil
        typeLabel.text = nil
    }
    
    func configure(title: String, type: EntityType) {
        titleLabel.text = title
        typeLabel.text = type.localized()
    }
    
}
