//
//  MarvelResponse.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataResponse<T>
}

// MARK: - DataClass
struct DataResponse<T: Codable>: Codable {
    let offset, limit, total, count: Int
    let results: T
}
