//
//  CharacterCell.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 20/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit



class CharacterCell: UITableViewCell {
    static let identifier = "CharacterCell"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
