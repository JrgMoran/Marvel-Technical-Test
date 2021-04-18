//
//  MarvelNetwork.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

protocol MarvelNetwork {
    func listCharacters(_ offset: Int) -> Single<MarvelResponse<[Character]>>
}
