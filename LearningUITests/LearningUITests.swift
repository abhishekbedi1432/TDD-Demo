//
//  LearningUITests.swift
//  LearningUITests
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import XCTest

class LearningUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       // XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.


        app = XCUIApplication()

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//
//        app.launch()
//        app.buttons["Show Flickr Feed"].tap()
//        app.navigationBars["Feed"].buttons["Back"].tap()
//
//    }

//    func testIsReset() {
//        XCTAssertTrue(app.isDisplayingMainViewController)
//    }
    
}

extension XCUIApplication {
    var isDisplayingMainViewController:Bool {
        print(otherElements)
        return otherElements["ViewController1"].exists

    }

}
