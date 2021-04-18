//
//  DataRepository.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class DataRepositoryImpl: DataRepository {

    let storageImage: StorageImage

    init(storageImage: StorageImage) {
        self.storageImage = storageImage
    }
    
    func getImage(from url: String) -> Single<UIImage> {
        return Single.create{[weak self] (single) -> Disposable in
            self?.storageImage.load(from: url, completion: { (result) in
                switch result {
                case .success(let image):
                    single(SingleEvent.success(image))
                case .failure(let error):
                    single(SingleEvent.error(error))
                }
            }, ignoreCache: false)
            return Disposables.create {}
        }
    }
}
