//
//  ListViewController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit
import Kingfisher

enum ListState {
    case loaded
    case loading
}

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UICollectionViewDataSourcePrefetching {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [MovieItem] = []
    
    var page: Int = 0
    var reachedEnd: Bool = false
    var query: String?
    
    var currentState: ListState = .loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.prefetchDataSource = self
        self.loadNextPage()
    }
    
    //MARK: - Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.currentState {
        case .loaded:
            return self.items.count
        case .loading:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.currentState == .loaded else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.reuseIdentifier, for: indexPath) as! MessageCollectionViewCell
            
            cell.setUp()
            return cell
        }
        
        if indexPath.item + 1 == self.items.count {
            self.loadNextPage()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.setUp(item: self.items[indexPath.row])
        return cell
    }
    
    
    private func loadNextPage() {
        guard !self.reachedEnd else { return }
        self.page += 1
        NetworkController.getImages(page: self.page) { [weak self] (items, page, totalPages) in
            guard items.count > 0 && page < totalPages else {
                self?.reachedEnd = true
                return
            }
            self?.currentState = .loaded
            self?.items += items
            self?.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let imgPaths = indexPaths.compactMap({ self.items[safe: $0.item]?.url })
        ImagePrefetcher(urls: imgPaths).start()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length = self.currentState == .loaded ? (collectionView.frame.width / 3 ) - 1 : collectionView.frame.width
        
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else { return }
        cell.imageView.kf.cancelDownloadTask()
    }
    
}
