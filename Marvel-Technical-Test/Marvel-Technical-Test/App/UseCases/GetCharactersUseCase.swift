//
//  GetCharactersUseCase.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class GetCharactersUseCase {
    let repository: MarvelRepository
    
    init(repository: MarvelRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction(_ offset: Int) -> Single<[Character]> {
        return repository.listCharacters(offset).observeOn(MainScheduler.instance)
    }
}
