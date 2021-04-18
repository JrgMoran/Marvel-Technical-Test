//
//  CharacterCellViewModel.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class CharacterCellViewModel: ViewModel & ViewModelType {
    
    struct Input {
        let character: Character
    }
    
    struct Output {
        let image: Observable<UIImage?>
    }
    
    var image: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    let getDataUseCase: GetDataUseCase
    
    init(getDataUseCase: GetDataUseCase) {
        self.getDataUseCase = getDataUseCase
        super.init(router: nil)
    }
    
    func transform(input: Input) -> Output {
        getDataUseCase(from: input.character.thumbnail.urlStr)
            .subscribe {[weak self] (data) in
                self?.image.on(.next(data))
            } onError: { (_) in
                
            }.disposed(by: disposeBag)

        return Output(image: image.asObservable())
    }
}
