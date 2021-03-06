//
//  Environment.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 11/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

public enum Schemes: String {
    case production = "PRO"
    case mock = "MOCK"
    case dev = "DEV"
    
    init?(string: String?) {
        guard let string = string else { return nil }
        switch string.uppercased() {
        case Schemes.production.rawValue:   self = .production
        case Schemes.mock.rawValue:         self = .mock
        default: return nil
        }
    }
}

public struct AppEnvironment {
    
    static let shared: AppEnvironment = AppEnvironment()
    
    let publicKey: String = "6c75002dea8b238a1509ba6cca02c164"
    
    let privateKey: String = "e541e6ca37bd2574daafee1a01102dce94288c10"
    
    public var scheme: Schemes {
        get {
            #if DEV
                return Schemes.dev
            #elseif PRO
                return Schemes.production
            #else
                return Schemes.mock
            #endif
        }
    }
    
    public var urlBase: String? {
        get {
            switch scheme {
            case .production:
                return "https://gateway.marvel.com:443"
            case .mock:
                return ""
            case .dev:
                return "https://gateway.marvel.com:443"
            }
        }
    }
}
