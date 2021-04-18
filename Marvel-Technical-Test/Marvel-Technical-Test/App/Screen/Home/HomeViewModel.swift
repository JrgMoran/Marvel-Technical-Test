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
    fileprivate let isHiddenTableView: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    var isMoreCharacters: Bool = true
    
    struct Input {
        let trigger: Observable<Void>
        let indexTap: Observable<Int>
        let indexWillView: Observable<Int>
    }
    
    struct Output {
        let characters: Observable<[Character]>
        let isHiddenTableView: Observable<Bool>
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
        
        characters.subscribe {[weak self] (event) in
            if let characters = event.element, characters.count > 0 {
                self?.isHiddenTableView.accept(false)
            } else {
                self?.isHiddenTableView.accept(true)
            }
        }.disposed(by: disposeBag)
        
        input.indexTap.subscribe{[weak self] (event) in
            
            if let index = event.element, let characters = self?.characters.value,
               index >= 0, index < characters.count {
                self?.router.navigateToDetail(of: characters[index])
            }
        }.disposed(by: disposeBag)
        
        return Output(characters: characters.asObservable(),
                      isHiddenTableView: isHiddenTableView.asObservable())
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

