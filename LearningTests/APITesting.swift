//
//  APITesting.swift
//  LearningTests
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import Learning

class APITesting: XCTestCase {
    
    class MockNetworkRequestHandler : NetworkRequestHandler {
     
        var plistName:String = ""
        var responseNode:String = ""
        private var responseString: String? = nil

        func getFeed(withURL url: URL, completionHandler: @escaping (NetworkResult) -> Void) {
            let data = responseString?.data(using: .utf8)
            let json = try! JSON.init(data: data!)
            completionHandler(NetworkResult.success(json))
        }
        
        init(withPlistName plistName:String, responseNode:String) {
            self.plistName = plistName
            self.responseNode = responseNode
            responseString = TestUtility.loadResponse(fromPlist: plistName, responseNode: responseNode)
        }
    }
    
    
    
    func testValidResponseLoading() {
        let router = MockNetworkRequestHandler.init(withPlistName: "APITestData", responseNode: "ValidResponse")
        let apiHandler = APIHandler.init(router: router)
        let payload = APIPayload.init(url: URL.init(string: "www.google.com")!)
        
        apiHandler.getFlickerFeed(withPayload: payload) { (networkResult) in
            
            switch networkResult {
            case .failure(let error):
                XCTFail((error?.localizedDescription)!)
            case .success(let json):
                XCTAssert(json["items"].arrayValue.count == 20, "Incorrect resultCount")
            }
            
        }
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
