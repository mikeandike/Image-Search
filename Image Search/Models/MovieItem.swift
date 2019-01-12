//
//  MovieItem.swift
//  Image Search
//
//  Created by Michael Sacks on 1/10/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

struct MovieItem {
    let url: URL
    let title: String?
    
    init?(_ dict: [String : Any]) {
        guard let posterPath = dict["poster_path"] as? String, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) else { return nil }
        
        self.url = url
        self.title = dict["title"] as? String
        
    }
}
