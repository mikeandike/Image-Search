//
//  ImgurItem.swift
//  Image Search
//
//  Created by Michael Sacks on 1/10/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

let allowedImgTypes = ["image/jpeg", "image/png"]

struct ImgurItem {
    let url: URL
    let title: String?
    
    init?(_ data: [String : Any]) {
        guard let dicts = data["images"] as? [[String : Any]] else { return nil }
        guard let type = dicts.first?["type"] as? String, allowedImgTypes.contains(type), let urlStr = dicts.first?["link"] as? String, let url = URL(string: urlStr) else {
            return nil
        }
        
        self.url = url
        self.title = data["title"] as? String
        
    }
}
