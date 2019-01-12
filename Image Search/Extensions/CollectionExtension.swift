//
//  CollectionExtension.swift
//  Image Search
//
//  Created by Michael Sacks on 1/11/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
