//
//  HomeViewModel.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 11/3/21.
//  Copyright (c) 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel, ViewModelType {
    
    let router: HomeRouter
    let getCharactersUseCase: GetCharactersUseCase
    
    fileprivate let characters: BehaviorRelay<[Character]> = BehaviorRelay(value: [])
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        let characters: Observable<[Character]>
    }
    
    // MARK: init & deinit
    init(router: HomeRouter, getCharactersUseCase: GetCharactersUseCase) {
        self.router = router
        self.getCharactersUseCase = getCharactersUseCase
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.subscribe { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading()
            
            weakSelf.getCharactersUseCase().subscribe(onSuccess: { (characters) in
                weakSelf.characters.accept(characters)
                weakSelf.hideLoading()
            }, onError: { (error) in
                weakSelf.process(error: error)
            }).disposed(by: weakSelf.disposeBag)
            
        }.disposed(by: disposeBag)
        return Output(characters: characters.asObservable())
    }
}

