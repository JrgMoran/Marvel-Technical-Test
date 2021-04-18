//
//  MarvelRepository.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

protocol MarvelRepository {
    func listCharacters(_ offset: Int) -> Single<[Character]>
}
