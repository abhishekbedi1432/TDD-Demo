//
//  APIHandler.swift
//  Learning
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (NetworkResult) -> Void

struct APIPayload {
    let url:URL
}

/// `APIHandler` is
struct APIHandler {

    let router: NetworkRequestHandler
    
    init(router: NetworkRequestHandler = URLSession.shared) {
        self.router = router
    }

    func getFlickerFeed(withPayload payload:APIPayload, andCompletionHandler handler: @escaping NetworkCompletionHandler) {
        let url = payload.url
        router.getFeed(withURL: url, completionHandler: handler)
    }
    
    
}
