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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    
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
        
    }
    
    // MARK: Binding
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = CharacterDetailViewModel.Input(trigger: rx.viewWillAppear)
        let _ = viewModel.transform(input: input)
    }

}
