//
//  NetworkClient.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 4/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class NetworkClient: Network {
    var downloader: Downloader
    
    init(with downloader: Downloader) {
        self.downloader = downloader
    }
}

extension NetworkClient: SessionNetwork {
    func login(user: String, pass: String) -> Single<Session> {
        let json = """
        {"token":"eyJzdWIiOiI1NGE4Y2U2MThlOTFiMGIxMzY2NWUyZjkiLCJpYXQiOiIxNDI0MTgwNDg0IiwiZXhwIjoiMTQyNTM5MDE0MiJ9"}
        """
        return decoder(from: Data(json.utf8))
    }
    
}
