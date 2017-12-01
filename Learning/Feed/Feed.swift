//
//  Feed.swift
//  Learning
//
//  Created by Abhishek Bedi on 01/12/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Feed {
    
    var title:String?
    var url:URL?
    
    init(json:JSON) {
        self.title = json["title"].stringValue
        self.url = URL(string: json["media"]["m"].stringValue)
    }
}
