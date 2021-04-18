//
//  MarvelRepositoryImpl.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class MarvelRepositoryImpl: MarvelRepository {
    
    let network: MarvelNetwork
    let cache: Cache
    
    init(network: MarvelNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func listCharacters(_ offset: Int) -> Single<[Character]> {
        return cache.cacheableRequest(network.listCharacters(offset),
                                      key: CacheKey.listCharacters(offset: offset))
            .map({ $0.data.results })
    }
    
    func character(of id: Int) -> Single<Character> {
        
        return cache.cacheableRequest(network.character(of: id),
                                          key: CacheKey.character(id: id))
            .flatMap { (response) -> Single<Character> in
                if let character = response.data.results.first {
                    return Single.just(character)
                } else {
                    return Single.error(AppError.notFound)
                }
            }
    }
}
