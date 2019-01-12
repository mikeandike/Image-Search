//
//  NetworkController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit
import Alamofire


class NetworkController {
    static let baseURL = "http://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2014-09-15&primary_release_date.lte=2014-10-22&page="
    static let apiKey = "64b6f3a69e5717b13ed8a56fe4417e71"
//    static let headers: HTTPHeaders = [
//        "Authorization": "Client-ID 64b6f3a69e5717b13ed8a56fe4417e71"
//    ]
    
    
    static func getImages(page: Int, result: @escaping (_ items: [MovieItem], _ page: Int, _ totalPages: Int) -> ()) {
                let requestURL = self.baseURL + "\(page)&api_key=" + apiKey
        
        Alamofire.request(requestURL).responseJSON { (response) in
            guard let json = response.result.value as? [String : Any], let page = json["page"] as? Int, let totalPages = json["total_pages"] as? Int else { result([], 0, 0); return }
            
            var results: [MovieItem] = []
            if let moviesDicts = json["results"] as? [[String : Any]] {
                results = moviesDicts.compactMap({ MovieItem($0) })
            }
            
            result(results, page, totalPages)
        }
    }

}
