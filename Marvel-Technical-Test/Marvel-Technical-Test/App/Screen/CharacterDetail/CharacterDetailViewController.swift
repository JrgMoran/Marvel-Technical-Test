//
//  CharacterDetailViewController.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 18/4/21.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailViewController: ViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicLabel: UILabel!
    @IBOutlet weak var comicCollectionView: UICollectionView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    // MARK: Injections
    var viewModel: CharacterDetailViewModel!
    
    // MARK: Attributes

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    // MARK: Configure View
    private func configureView(){
        comicLabel.text(R.text.comic, withSkin: LabelSkin.sectionTitle)
        seriesLabel.text(R.text.series, withSkin: LabelSkin.sectionTitle)
    }
    
    // MARK: Binding
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = CharacterDetailViewModel.Input(trigger: rx.viewWillAppear)
        let output = viewModel.transform(input: input)
        output.character.subscribe {[weak self] (event) in
            if let character = event.element {
                self?.configure(character: character)
            }
        }.disposed(by: disposeBag)
        
        output.image.bind(to: imageView.rx.image).disposed(by: disposeBag)
    }
    
    private func configure(character: Character) {
        nameLabel.text(character.name, withSkin: LabelSkin.mainTitle)
        descriptionLabel.text(character.resultDescription, withSkin: LabelSkin.body)
        
    }

}
