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
    case noSearch
    case noResults
}

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UICollectionViewDataSourcePrefetching {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [ImgurItem] = []
    
    var page: Int = 0
    var reachedEnd: Bool = false
    var query: String?
    
    var lastQuerySearch: DispatchTime = DispatchTime.now()
    
    var currentState: ListState = .noSearch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hideKeyboardWhenTappedAround()
        self.navigationController?.view.hideKeyboardWhenTappedAround()
        self.collectionView.prefetchDataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            let item = self.items[self.collectionView.indexPathsForSelectedItems?.first?.item ?? 0]
            vc.item = item
        }
    }
    
    
    //MARK: - Search Bar Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let str = textField.text as NSString? else { return true }
        let searchQuery = str.replacingCharacters(in: range, with: string)
        self.query = searchQuery
        self.lastQuerySearch = DispatchTime.now()
        
        let delay = DispatchTimeInterval.milliseconds(250)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) { [weak self] in
            guard let lastQuerySearch = self?.lastQuerySearch, lastQuerySearch + delay <= DispatchTime.now() else { return }
            self?.lastQuerySearch = DispatchTime.now()
            self?.performSearch(searchQuery)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.reloadList(items: [], state: .noSearch)
        return true
    }
    
    private func performSearch(_ searchQuery: String) {
        self.reloadList(items: [], state: .loading)
        self.page = 0
        self.reachedEnd = false
        NetworkController.getImages(forTerm: searchQuery, page: 0) { [weak self] (items) in
            self?.reloadList(items: items, state: items.count > 0 ? .loaded : .noResults)
        }
    }
    
    private func reloadList(items: [ImgurItem], state: ListState) {
        self.items = items
        self.currentState = state
        self.collectionView.reloadData()
    }
    
    //MARK: - Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.currentState == .loaded else { return 1 }
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.currentState == .loaded else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.reuseIdentifier, for: indexPath) as! MessageCollectionViewCell
            
            cell.setUp(currentState: self.currentState)
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
        guard let query = self.query, !self.reachedEnd else { return }
        self.page += 1
        NetworkController.getImages(forTerm: query, page: self.page) { [weak self] (items) in
            guard items.count > 0 else {
                self?.reachedEnd = true
                return
            }
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: true) }
        guard indexPath.item < self.items.count else { return }
        self.performSegue(withIdentifier: "listToDetail", sender: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
 
    
}
