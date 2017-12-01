//
//  FeedViewController.swift
//  Learning
//
//  Created by Abhishek Bedi on 17/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import UIKit
import SwiftyJSON
import TTGSnackbar
import Kingfisher

class FeedViewController: UIViewController {

    @IBOutlet weak var datasource: FeedCollectionViewDatasource!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var apiHandler:APIHandler = APIHandler()

    deinit {
        print("Deinit called")
    }
    
    fileprivate func setupCollectionViewDatasource() {
        datasource.OnItemSelection = { item in
            print("\(String(describing: item.title)) ")
        }
        datasource.willDisplayFooter = {
            self.loadFeed()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewDatasource()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @discardableResult
    private func showMessage(error:String, duration:TTGSnackbarDuration = .short) -> TTGSnackbar {
        let snackbar = TTGSnackbar(message: error, duration: duration)
        snackbar.containerView = self.view
        snackbar.animationType = .slideFromTopBackToTop
        snackbar.show()
        return snackbar
    }

    @IBAction func refreshButtonAction(_ sender: Any) {
        loadFeed()
    }

    private func loadFeed() {
        
        let snackbar = showMessage(error: "Loading ...", duration: .forever)
        
        guard let url = URL.init(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else {
            assertionFailure("Malformed URL")
            return
        }
        
        let payload = APIPayload(url: url)
        apiHandler.getFlickerFeed(withPayload: payload) { [weak self] networkResult in
            
            guard let strongSelf = self else {
                assertionFailure("Self deallocated")
                return
            }
            
            snackbar.dismiss()
            
            switch networkResult {
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.showMessage(error: error?.localizedDescription ?? "X")
                }
            case .success(let json):
                var feeds:[Feed] = []
                let items = json["items"].arrayValue
                for item in items {
                    let feed = Feed(json: item)
                    feeds.append(feed)
                }
                strongSelf.datasource.configure(strongSelf.collectionView, items:feeds)
            }
            
        }
    }
    
    
}

