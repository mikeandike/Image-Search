//
//  ListViewController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageUrls: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkController.getImages(forTerm: "Goat") { [weak self] (images) in
            self?.imageUrls = images
            self?.collectionView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            let url = self.imageUrls[self.collectionView.indexPathsForSelectedItems?.first?.item ?? 0]
            print(url)
            vc.imageUrl = url
        }
    }
    
    
    //MARK: - Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        let imageUrl = self.imageUrls[indexPath.row]
        cell.imageView.kf.setImage(with: imageUrl)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width / 3 ) - 1
        
        return CGSize(width: length, height: length)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: true) }
        guard indexPath.item < self.imageUrls.count else { return }
        self.performSegue(withIdentifier: "listToDetail", sender: nil)
    }
}
