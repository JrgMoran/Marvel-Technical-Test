//
//  DataRepository.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

protocol DataRepository {
    func getImage(from url: String) -> Single<UIImage>
}
