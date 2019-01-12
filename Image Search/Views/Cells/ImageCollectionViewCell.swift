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
    
    func setUp(item: MovieItem) {
        
        self.imageView.kf.setImage(with: item.url, placeholder: #imageLiteral(resourceName: "loading"))
        self.textLabel.text = item.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = #imageLiteral(resourceName: "loading")
    }
    
}
