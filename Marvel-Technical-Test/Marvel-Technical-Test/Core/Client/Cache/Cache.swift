//
//  Cache.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

enum CacheKey {
    
    case listCharacters(offset: Int)
    
    var value: String {
        switch self {
        
        case .listCharacters(let offset):
            return "listCharacters?offset=\(offset)"
        }
    }
}

protocol Cache {
    func cacheableRequest<T>(_ request: Single<T>, key: CacheKey) -> Single<T>
    func cleanCache()
    func remove(_ key: CacheKey)
}
