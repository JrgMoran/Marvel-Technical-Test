//
//  GetCharacterUseCase.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 18/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class GetCharacterUseCase {
    let repository: MarvelRepository
    
    init(repository: MarvelRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction(id: Int) -> Single<Character> {
        return repository.character(of: id).observeOn(MainScheduler.instance)
    }
}
