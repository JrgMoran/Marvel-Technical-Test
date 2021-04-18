//
//  StorageImage.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import UIKit

class StorageImage: Storage {
    
    typealias T = UIImage
    
    var folder: StorageFolder { StorageFolder.images }
    
    var maxDays: Double { return 15 }
    
    var downloader: Downloader
    
    required init(downloader: Downloader) {
        self.downloader = downloader
    }
    
    func load(from request: URLRequest, completion: @escaping (Result<UIImage, AppError>) -> Void, ignoreCache: Bool) {
        load(from: request, completion: { (result) -> Bool in
            switch result {
            
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(Result.success(image))
                    return true
                } else {
                    completion(Result.failure(AppError.notFound))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
            return false
        }, ignoreCache: ignoreCache)
    }
    
    func load(from url: String, completion: @escaping (Result<UIImage, AppError>) -> Void, ignoreCache: Bool) {
        
        if let url = URL(string: url) {
            load(from: URLRequest(url: url), completion: completion, ignoreCache: ignoreCache)
        } else {
            completion(Result.failure(AppError.badUrl))
        }
    }
}
