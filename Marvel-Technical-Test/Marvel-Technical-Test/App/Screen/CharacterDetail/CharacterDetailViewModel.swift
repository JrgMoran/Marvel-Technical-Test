//
//  CharacterDetailViewModel.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 18/4/21.
//  Copyright (c) 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterDetailViewModel: ViewModel, ViewModelType {
    
    let router: CharacterDetailRouter
    let character: Character
    
    struct Input { }
    
    struct Output { }
    
    // MARK: init & deinit
    init(router: CharacterDetailRouter, character: Character) {
        self.router = router
        self.character = character
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        return Output()
    }
    
    // MARK: Logic
}

