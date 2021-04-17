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
        let imageData: Observable<Data?>
    }
    
    var imageData: BehaviorSubject<Data?> = BehaviorSubject(value: nil)
    
    init() {
        super.init(router: nil)
    }
    
    func transform(input: Input) -> Output {
        return Output(imageData: imageData.asObservable())
    }
}
