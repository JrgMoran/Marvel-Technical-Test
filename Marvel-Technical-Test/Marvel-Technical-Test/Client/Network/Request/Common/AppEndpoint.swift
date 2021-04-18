//
//  Endpoint.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán
//

import Foundation

enum AppEndpoint {
    case listCharacters
    case detailCharacter
    
    var path: String {
        switch self {
        case .listCharacters,
             .detailCharacter: return "/v1/public/characters"
        }
    }
    
    var url: URL? {
        return URL(string: "\(AppEnvironment.shared.urlBase ?? "")\(self.path)")
    }
}
