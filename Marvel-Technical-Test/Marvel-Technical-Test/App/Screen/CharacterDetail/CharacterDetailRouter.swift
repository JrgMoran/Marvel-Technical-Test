//
//  CharacterDetailRouter.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 18/4/21.
//

import Foundation

class CharacterDetailRouter: Router {
    
    @discardableResult
    init(with character: Character) {
        super.init()
        let viewController = CharacterDetailViewController()
        
        viewController.viewModel = injector.container.resolve(CharacterDetailViewModel.self, arguments: self, character)
        navigate(to: viewController, mode: .push)
    }
}

