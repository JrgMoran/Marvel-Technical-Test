//
//  CharacterCell.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    static let identifier = "CharacterCell"
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    
    func configure(with character: Character){
        nameCharacter.text(character.name, withSkin: LabelSkin.cellName)
    }
    
    override func prepareForReuse() {
        imageCharacter.image = nil
        nameCharacter.text = nil
        super.prepareForReuse()
    }
}
