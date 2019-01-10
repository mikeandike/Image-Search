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
    
    /* https://api.imgur.com/3/gallery/search/time/{pagenumber }?q={search parameters} */
    
    static let baseURL = "https://api.imgur.com/3/gallery/search/time/"
    static let headers: HTTPHeaders = [
        "Authorization": "Client-ID 126701cd8332f32"
    ]
    
    static let allowedImgTypes = ["image/jpeg", "image/png"]
    
    static func getImages(forTerm queryString: String, result: @escaping (_ images: [URL]) -> ()) {
        let requestURL = self.baseURL + "1" + "?q=" + queryString
        let request = Alamofire.request(requestURL, headers: self.headers).responseJSON { (response) in
            var results: [URL] = []
            defer {
                result(results)
            }
            guard let json = response.result.value as? [String : Any] else {
                return
            }
            guard let data = json["data"] as? [[String : Any]] else {
                return
            }
            
            results = data.compactMap({
                guard let imgDict = $0["images"] as? [[String : Any]] else {
                    return nil
                }
                guard let type = imgDict.first?["type"] as? String, self.allowedImgTypes.contains(type) else { return nil }
                guard let urlStr = imgDict.first?["link"] as? String else {
                    return nil
                }
                return URL(string: urlStr)
            })
        }
    }

}
