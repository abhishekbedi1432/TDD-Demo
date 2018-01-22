//
//  TestUtility.swift
//  LearningTests
//
//  Created by Abhishek Bedi on 01/12/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation

struct TestUtility {
    static func loadResponse(fromPlist plist:String, responseNode:String) -> String? {
        guard
            let fileURL = Bundle(for: LearningTests.classForCoder()).url(forResource: plist, withExtension: "plist"),
            let data = try? Data(contentsOf: fileURL),
            let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil),
            let json = result as? [String:String]

            else {
                assertionFailure("Plist/Response Node not configured properly")
                return nil
        }
        return json[responseNode]
    }
    
}

