//
//  AppInjector.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import Swinject

final class AppInjector {
    let container: Container
    static let shared: AppInjector = AppInjector()
    
    private init() {
        container = Container()
        setup()
    }
    
    private func setup() {
        //MARK: - Helpers
        container.register(Downloader.self) { r in
            Downloader()
        }
        
        // MARK: - Client
        container.register(SessionNetwork.self) { r in
            switch AppEnvironment.shared.scheme {
            case .production:
                return NetworkClient(with: r.resolve(Downloader.self)!)
            case .mock:
                return NetworkMockClient()
            case .dev:
                return NetworkClient(with: r.resolve(Downloader.self)!)
            }
        }
        
        container.register(MarvelNetwork.self) { r in
            switch AppEnvironment.shared.scheme {
            case .production:
                return NetworkClient(with: r.resolve(Downloader.self)!)
            case .mock:
                return NetworkMockClient()
            case .dev:
                return NetworkClient(with: r.resolve(Downloader.self)!)
            }
        }
        
        container.register(KeyChain.self) { r in
            KeyChainImpl()
        }
        
        container.register(Cache.self) { r in
            CacheClient.shared
        }
        
        container.register(UserData.self) { r in
            UserDataImpl(keyChain: r.resolve(KeyChain.self))
        }
        
        container.register(StorageImage.self) { r in
            StorageImage(downloader: r.resolve(Downloader.self)!)
        }
        
        // MARK: - Repositories
        
        container.register(SessionRepository.self) { r in
            SessionRepositoryImpl(network: r.resolve(SessionNetwork.self)!,
                                  userData: r.resolve(UserData.self)!)
        }
        
        container.register(RelogableRepository.self) { r in
            SessionRepositoryImpl(network: r.resolve(SessionNetwork.self)!,
                                  userData: r.resolve(UserData.self)!)
        }
        
        container.register(MarvelRepository.self) { r in
            MarvelRepositoryImpl(network: r.resolve(MarvelNetwork.self)!,
                                 cache: r.resolve(Cache.self)!)
        }
        
        container.register(DataRepository.self) { r in
            DataRepositoryImpl(storageImage: r.resolve(StorageImage.self)!)
        }
        
        // MARK: - UseCases
        container.register(LoginUseCase.self) { r in
            LoginUseCase(repository: r.resolve(SessionRepository.self)!)
        }
        
        container.register(GetCharactersUseCase.self) { r in
            GetCharactersUseCase(repository: r.resolve(MarvelRepository.self)!)
        }
        
        container.register(GetDataUseCase.self) { r in
            GetDataUseCase(repository: r.resolve(DataRepository.self)!)
        }
        
        // MARK: - ViewModels
        container.register(SplashViewModel.self) { r, router in
            SplashViewModel(router: router)
        }
        
        container.register(HomeViewModel.self) { r, router in
            HomeViewModel(router: router, getCharactersUseCase: r.resolve(GetCharactersUseCase.self)!)
        }
        
        container.register(CharacterCellViewModel.self) { r in
            CharacterCellViewModel(getDataUseCase: r.resolve(GetDataUseCase.self)!)
        }

    }
}
