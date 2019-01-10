//
//  ListViewController.swift
//  Image Search
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [UIImage] = [UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!, UIImage(named: "logo")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            vc.image = self.images[self.collectionView.indexPathsForSelectedItems?.first?.item ?? 0]
        }
    }
    
    
    //MARK: - Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        let image = self.images[indexPath.row]
        cell.imageView.image = image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width / 3 ) - 1
        
        return CGSize(width: length, height: length)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: true) }
        guard indexPath.item < self.images.count else { return }
        self.performSegue(withIdentifier: "listToDetail", sender: nil)
    }
}
