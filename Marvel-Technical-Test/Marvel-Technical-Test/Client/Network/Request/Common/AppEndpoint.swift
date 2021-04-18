//
//  Endpoint.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán
//

import Foundation

enum AppEndpoint {
    case listCharacters
    case detailCharacter(id: Int)
    
    var path: String {
        switch self {
        case .listCharacters:           return "/v1/public/characters"
        case .detailCharacter(let id):  return "/v1/public/characters/\(id)"
        }
    }
    
    var url: URL? {
        return URL(string: "\(AppEnvironment.shared.urlBase ?? "")\(self.path)")
    }
}
