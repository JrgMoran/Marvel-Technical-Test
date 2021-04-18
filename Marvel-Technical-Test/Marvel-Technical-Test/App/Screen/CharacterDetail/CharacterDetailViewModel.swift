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
    let getCharacterUseCase: GetCharacterUseCase
    let characterReactive: BehaviorRelay<Character?> = BehaviorRelay(value: nil)
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        let characters: Observable<Character>
    }
    
    // MARK: init & deinit
    init(router: CharacterDetailRouter,
         character: Character,
         getCharacterUseCase: GetCharacterUseCase) {
        self.router = router
        self.character = character
        self.getCharacterUseCase = getCharacterUseCase
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        
        input.trigger.subscribe {[weak self] (_) in
            guard let weakSelf = self else { return }
            
            weakSelf.getCharacterUseCase(id: weakSelf.character.id).subscribe { (character) in
                weakSelf.characterReactive.accept(character)
            } onError: { (_) in
                weakSelf.characterReactive.accept(weakSelf.character)
            }.disposed(by: weakSelf.disposeBag)
            
        }.disposed(by: disposeBag)
        
        return Output(characters: characterReactive.asObservable().filterNil())
    }
    
    // MARK: Logic
}

