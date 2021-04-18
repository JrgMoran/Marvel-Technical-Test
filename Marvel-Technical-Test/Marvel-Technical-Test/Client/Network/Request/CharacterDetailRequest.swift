//
//  CharacterDetailRequest.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 18/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct CharacterDetailRequest: AppRequest {
    var endpoint: AppEndpoint { .detailCharacter(id: id) }
    
    var method: AppRequestMethod { .get }
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}
