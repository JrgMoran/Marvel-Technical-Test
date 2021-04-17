//
//  Cache.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

enum CacheKey: String {
    case listCharacters
}

protocol Cache {
    func cacheableRequest<T>(_ request: Single<T>, key: CacheKey) -> Single<T>
    func cleanCache()
    func remove(_ key: CacheKey)
}
