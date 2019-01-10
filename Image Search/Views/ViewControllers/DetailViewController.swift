//
//  DetailViewController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = self.image else { self.navigationController?.popViewController(animated: true); return }
        
        self.imageView.image = image
        
    }
    


}
