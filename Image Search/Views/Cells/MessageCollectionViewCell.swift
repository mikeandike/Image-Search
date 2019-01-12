//
//  MessageCollectionViewCell.swift
//  Image Search
//
//  Created by Michael Sacks on 1/10/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var textLabel: UILabel!
    
    func setUp(currentState: ListState) {
        switch currentState {
        case .loaded: break
        case .loading:
            self.textLabel.text = "Loading..."
        case .noResults:
            self.textLabel.text = "No results found. Please try a new search!"
        case .noSearch:
            self.textLabel.text = "Enter something in the search bar above to search Imgur!"
        }
    }
}
