//
//  FeedTesting.swift
//  LearningTests
//
//  Created by Abhishek Bedi on 01/12/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON

@testable import Learning

class FeedTesting: XCTestCase {
    
    func testFeedSHouldHaveTitleAndImageUrl() {
        
        let json: JSON =  ["title":"FeedTitle", "media":["m":"https://farm5.staticflickr.com/4554/24888744288_9a5081344a_m.jpg"]]
        
        let feed = Feed(json: json)
        XCTAssert(feed.title == "FeedTitle")
        XCTAssert(feed.url == URL.init(string: "https://farm5.staticflickr.com/4554/24888744288_9a5081344a_m.jpg"))
        
        
    }
}
