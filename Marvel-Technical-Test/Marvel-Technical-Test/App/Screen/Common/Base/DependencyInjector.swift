//
//  DependencyInjector.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

class DependencyInjector {
    
    // MARK: - Client
    private var network: SessionNetwork & MarvelNetwork {
        switch AppEnvironment.shared.scheme {
        case .production:
            return NetworkClient(with: Downloader())
        case .mock:
            return NetworkMockClient()
        case .dev:
            return NetworkClient(with: Downloader())
        }
    }
    
    private lazy var keyChaim: KeyChain = KeyChainImpl()
    private lazy var userData: UserData = UserDataImpl(keyChain: keyChaim)
    
    // MARK: - Repository
    private lazy var sessionRepository: SessionRepository = SessionRepositoryImpl(network: network, userData: userData)
    private lazy var marvelRepository: MarvelRepository = MarvelRepositoryImpl(network: network)
    
    // MARK: - UseCases
    lazy var loginUseCase : LoginUseCase = LoginUseCase(repository: self.sessionRepository)
    lazy var getCharacterUseCase: GetCharactersUseCase = GetCharactersUseCase(repository: marvelRepository)
    
    // MARK: - ViewControllers
    func firstViewController() -> ViewController {
        let viewController = SplashViewController()
        viewController.viewModel = SplashViewModel(router: SplashRouter())
        return viewController
        
    }
}
