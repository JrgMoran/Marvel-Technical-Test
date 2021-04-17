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
    
    var isMoreCharacters: Bool = true
    
    struct Input {
        let trigger: Observable<Void>
        let indexTap: Observable<Int>
        let indexWillView: Observable<Int>
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
        input.indexWillView.subscribe { [weak self](event) in
            guard let weakSelf = self, let index: Int = event.element else { return }
           
            if index > weakSelf.characters.value.count - 2 {
                weakSelf.getCharacters(offset: weakSelf.characters.value.count)
            }
        }.disposed(by: disposeBag)
        
        input.trigger.subscribe { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.getCharacters(offset: 0)

        }.disposed(by: disposeBag)
        return Output(characters: characters.asObservable())
    }
    
    func getCharacters(offset: Int) {
        if characters.value.count == 0 {
            isMoreCharacters = true
        }
        if isMoreCharacters {
            showLoading()
            getCharactersUseCase(offset).subscribe(onSuccess: { [weak self] (characters) in
                guard let weakSelf = self else { return }
                weakSelf.hideLoading()
                if characters.count == 0 {
                    weakSelf.isMoreCharacters = false
                    return
                }
                var allCharacters = weakSelf.characters.value
                allCharacters.append(contentsOf: characters)
                weakSelf.characters.accept(allCharacters)
            }, onError: {[weak self] (error) in
                self?.process(error: error)
            }).disposed(by: disposeBag)
        }
    }
}

