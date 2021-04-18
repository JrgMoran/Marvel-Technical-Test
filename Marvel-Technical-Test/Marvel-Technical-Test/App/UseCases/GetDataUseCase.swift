//
//  GetDataUseCase.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class GetDataUseCase {
    let repository: DataRepository
    
    init(repository: DataRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction(from urlStr: String) -> Single<UIImage> {
        return repository.getImage(from: urlStr).observeOn(MainScheduler.instance)
    }
}
