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
    
    struct Input { }
    
    struct Output { }
    
    // MARK: init & deinit
    init(router: HomeRouter) {
        self.router = router
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        return Output()
    }
    
    // MARK: Logic
}

