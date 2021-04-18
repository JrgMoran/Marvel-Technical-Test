//
//  Dictionary+Extensions.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
extension Dictionary {
    mutating func merge(dict: [Key: Value]?){
        guard let dict = dict else { return }
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
