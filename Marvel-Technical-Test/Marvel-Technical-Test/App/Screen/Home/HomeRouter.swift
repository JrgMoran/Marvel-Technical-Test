//
//  HomeRouter.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 11/3/21.
//

import Foundation

class HomeRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
        let viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(router: self, getCharactersUseCase: injector.getCharacterUseCase)
        navigate(to: viewController, mode: .new)
    }
}

