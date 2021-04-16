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
    
    init(network: MarvelNetwork) {
        self.network = network
    }
    
    func listCharacters() -> Single<[Character]> {
        return network.listCharacters().map({ $0.data.results })
    }
}
