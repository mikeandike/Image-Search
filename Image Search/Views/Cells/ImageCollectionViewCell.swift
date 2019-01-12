//
//  ImageCollectionViewCell.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func setUp(item: ImgurItem) {
        
        self.imageView.kf.setImage(with: item.url, placeholder: #imageLiteral(resourceName: "loading"), options: [
            .processor(DownsamplingImageProcessor(size: self.imageView.frame.size)),
            .processor(ResizingImageProcessor(referenceSize: self.imageView.frame.size, mode: .aspectFit)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
            ])
        self.textLabel.text = item.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = #imageLiteral(resourceName: "loading")
    }
}
