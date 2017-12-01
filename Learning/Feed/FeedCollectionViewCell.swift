//
//  FeedCollectionViewCell.swift
//  Learning
//
//  Created by Abhishek Bedi on 20/11/2017.
//  Copyright © 2017 Abhishek Bedi. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 5.0
        
        titleLabel.text = nil
    }
}
