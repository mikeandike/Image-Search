//
//  DetailViewController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl: URL! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imageUrl = self.imageUrl else { self.navigationController?.popViewController(animated: true); return }
        
        self.imageView.kf.setImage(with: self.imageUrl)
        
    }
    


}
