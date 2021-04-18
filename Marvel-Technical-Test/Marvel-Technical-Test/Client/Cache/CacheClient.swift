//
//  Cache.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

struct CacheableObject {
    let object: Any?
    let expiredDate: Date
    let key: CacheKey
    
    init(with object: Any?, key: CacheKey){
        self.object = object
        self.key = key
        self.expiredDate = Date().addingTimeInterval(60)
    }
}

class CacheClient: Cache {
    static var shared: CacheClient = CacheClient()
    
    fileprivate var objectsCached: [CacheableObject] = []
    
    func cacheableRequest<T>(_ request: Single<T>, key: CacheKey) -> Single<T> {
        cleanExpired()
        
        if let objectFromCache = objectsCached.first(where: {$0.key.value == key.value}) {
            if let object = objectFromCache.object as? T{
                return Single.just(object)
            }
        }
        return requestWithCache(request, key: key)
    }
    
    func cleanCache() {
        self.objectsCached.removeAll()
    }
    
    func remove(_ key: CacheKey){
        if let index = objectsCached.firstIndex(where: {$0.key.value == key.value}){
            objectsCached.remove(at: index)
            remove(key)
        }
    }
    
    fileprivate func requestWithCache<T>(_ request: Single<T>, key: CacheKey) -> Single<T> {
        return request.map {[weak self] (data) in
            self?.remove(key)
            self?.objectsCached.append(CacheableObject(with: data, key: key))
            return data
        }
    }
    
    fileprivate func cleanExpired() {
        objectsCached.forEach { (objectFromCache) in
            if Date() > objectFromCache.expiredDate {
                remove(objectFromCache.key)
            }
        }
    }
    
}
