//
//  CharacterCell.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CharacterCell: UITableViewCell {
    static let identifier = "CharacterCell"
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    var viewModel: CharacterCellViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    func configure(with character: Character){
        viewModel = AppInjector.shared.container.resolve(CharacterCellViewModel.self)
        nameCharacter.text(character.name, withSkin: LabelSkin.cellName)
        let output = viewModel.transform(input: CharacterCellViewModel.Input(character: character))
        
        output.imageData.filterNil().map({ UIImage(data: $0)}).bind(to: imageCharacter.rx.image).disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        viewModel = nil
        imageCharacter.image = nil
        nameCharacter.text = nil
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
