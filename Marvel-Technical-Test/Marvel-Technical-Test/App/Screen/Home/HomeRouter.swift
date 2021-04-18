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
        viewController.viewModel = injector.container.resolve(HomeViewModel.self, argument: self)
        navigate(to: viewController, mode: .new)
    }
    
    func navigateToDetail(of character: Character) {
        // TODO:
    }
}

