//
//  FeedCollectionViewDatasource.swift
//  LearningTests
//
//  Created by Abhishek Bedi on 01/12/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import Learning

class FeedCollectionViewDatasourceTest: XCTestCase {
    var feeds:[Feed] {
         let json: JSON =  ["title":"FeedTitle", "media":["m":"https://farm5.staticflickr.com/4554/24888744288_9a5081344a_m.jpg"]]
        let f1 = Feed.init(json: json)
        return [f1]
    }
    
    
    func testDatasourceEmpty() {
        let datasource = FeedCollectionViewDatasource()
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        datasource.configure(collectionView, items: [])
        XCTAssert(datasource.items.count == 0)
    }
    
    func testDatasourceNonEmpty() {
        let datasource = FeedCollectionViewDatasource()
      
        let view  = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        let collectionView = UICollectionView(frame: view.frame,
                                              collectionViewLayout: UICollectionViewFlowLayout())
       
        view.addSubview(collectionView)
        
        datasource.configure(collectionView, items: feeds)
        datasource.configure(collectionView, items: feeds)
        XCTAssert(datasource.items.count == feeds.count * 2)
    }
    
}
