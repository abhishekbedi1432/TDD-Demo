//
//  NetworkHandler.swift
//  Learning
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum NetworkResult {
    case success(JSON)
    case failure(Error?)
}

protocol NetworkRequestHandler {
    func getFeed(withURL url: URL, completionHandler:@escaping (NetworkResult) -> Void)
}

extension URLSession : NetworkRequestHandler {
    
    func getFeed(withURL url: URL, completionHandler:@escaping (NetworkResult) -> Void) {
        
        print("Hit Network Req: \(url.absoluteString)")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.failure(error))
                }
                return
            }
            do {
                let json = try JSON(data: data!)
                
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.success(json))
                }
            }
            catch(let error) {
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.failure(error))
                }
            }
            
        }
        task.resume()
    }
}
