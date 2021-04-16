//
//  ListCharacterRequest.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct ListCharacterRequest: AppRequest {
    var endpoint: AppEndpoint { .listCharacters }
    
    var method: AppRequestMethod { .get } 
}
