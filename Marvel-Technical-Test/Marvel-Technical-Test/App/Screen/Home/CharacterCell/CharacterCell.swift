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
    @IBOutlet weak var viewText: UIView! 
    
    var viewModel: CharacterCellViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    func configure(with character: Character){
        viewModel = AppInjector.shared.container.resolve(CharacterCellViewModel.self)
        nameCharacter.text(character.name, withSkin: LabelSkin.cellName)
        let output = viewModel.transform(input: CharacterCellViewModel.Input(character: character))
        
        output.image.filterNil().bind(to: imageCharacter.rx.image).disposed(by: disposeBag)
        imageCharacter.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    override func prepareForReuse() {
        viewModel = nil
        imageCharacter.image = nil
        nameCharacter.text = nil
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
    
    func applyGradient() {
        if viewText.layer.sublayers?.count == 1 {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.grayClear.cgColor]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            viewText.layer.insertSublayer(gradient, at: 0)
        }
    }
}
