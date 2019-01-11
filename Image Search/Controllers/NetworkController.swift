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
    static let baseURL = "https://api.imgur.com/3/gallery/search/time/"
    static let headers: HTTPHeaders = [
        "Authorization": "Client-ID 126701cd8332f32"
    ]
    
    static func getImages(forTerm queryString: String, result: @escaping (_ items: [ImgurItem]) -> ()) {
        let cleanQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? queryString
        let requestURL = self.baseURL + "1" + "?q=" + cleanQueryString
        
        Alamofire.request(requestURL, headers: self.headers).responseJSON { (response) in
            guard let json = response.result.value as? [String : Any], let data = json["data"] as? [[String : Any]] else { result([]); return }
            
            let results: [ImgurItem] = data.compactMap({ return ImgurItem($0) })
            
            result(results)
        }
    }

}
