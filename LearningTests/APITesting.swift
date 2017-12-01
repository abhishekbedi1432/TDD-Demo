//
//  APITesting.swift
//  LearningTests
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import XCTest
@testable import Learning

typealias JSON = [String:Any]

//extension String {
//    func toJson() -> JSON? {
//        guard
//            let data = data(using: String.Encoding.utf8),
//            let json = try? JSONSerialization.data(withJSONObject: data, options: [])
//        else {
//            return nil
//        }
//
//        return json
//    }
//}



class APITesting: XCTestCase {
    
    class MockNetworkRequestHandler : NetworkRequestHandler {
        func getFeed(withURL url: URL, completionHandler: @escaping (NetworkResult) -> Void) {
            <#code#>
        }
        
        var plistName:String = ""
        var responseNode:String = ""
        private var response: (string:String?,data:Data?) = (nil,nil)
        
        
        private func loadResponse(fromPlist plist:String, responseNode:String) -> (String?,Data?) {
            guard
                let fileURL = Bundle(for: type(of: self)).url(forResource: plist, withExtension: "plist"),
                let data = try? Data(contentsOf: fileURL),
                let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil),
                let json = result as? JSON,
                let sampleResponseString = json[responseNode] as? String
                //let sampleResponseJSON = sampleResponseString.toJson()
        
                else {
                    assertionFailure("PList/Response Node not configured properly")
                    return (nil,nil)
            }
            
            return (sampleResponseString,data)
        }
        
        init(withPlistName plistName:String, responseNode:String) {
            self.plistName = plistName
            self.responseNode = responseNode
            response = loadResponse(fromPlist: plistName, responseNode: responseNode)
        }
        
        func getFeed(withURL url: URL, completionHandler:@escaping (Data?,URLResponse?,Error?) -> Void) {
            completionHandler(response.data,nil,nil)
        }

    }
    
    
    
    func testValidResponseLoading() {
        let router = MockNetworkRequestHandler.init(withPlistName: "APITestData", responseNode: "iTunesValidResponse")
        let apiHandler = APIHandler.init(router: router)
        let payload = APIPayload.init(url: URL.init(string: "www.google.com")!)
        
        apiHandler.getFlickerFeed(withPayload: payload) { (data, response, error) in
            XCTAssertTrue(data != nil)
            XCTAssertTrue(response == nil)
            XCTAssertTrue(error == nil)
            let a = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            //XCTAssertTrue(responseString!.contains("Jack Johnson"))
            
            
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
