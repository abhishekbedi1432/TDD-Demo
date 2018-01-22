//
//  FeedCollectionViewDatasource.swift
//  Learning
//
//  Created by Abhishek Bedi on 20/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCollectionViewDatasource:NSObject {
    
    private var collectionView:UICollectionView!
    var willDisplayFooter:(() -> ())?
    var OnItemSelection:((Feed) ->())?
    
    var items:[Feed] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    func configure(_ collectionView: UICollectionView, items:[Feed]) {
        self.collectionView = collectionView
        print("ItemsCount: \(items.count)")
        self.items += items
        
    }
}
extension FeedCollectionViewDatasource : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let rect = collectionView.bounds
//        return CGSize(width: rect.width/3, height: rect.height/4)
//    }
}
extension FeedCollectionViewDatasource: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            print("viewFor Footer called")
            
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FeedCollectionViewFooter", for: indexPath)
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionElementKindSectionFooter {
            
            print("Footer is displayed")
            willDisplayFooter?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        OnItemSelection?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    fileprivate func updateProgress(forCell cell:FeedCollectionViewCell, progress:Float) {
        UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
            cell.progressView.progress = progress
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell {
            
            let item = items[indexPath.row]
            
            if let url = item.url {
                cell.progressView.isHidden = false

                cell.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "flickr"), options: nil, progressBlock: { (receivedSize, totalSize) in
                    let percentage: Float = Float(receivedSize) / Float(totalSize)
                    print("\(receivedSize) - \(totalSize) and  \(percentage) %")
                    cell.progressView.progress = percentage
                }, completionHandler: { (image, error, cacheType, url) in
                    print("Image download successful")
                    cell.progressView.isHidden = true
                    cell.titleLabel.text = item.title
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }
}







