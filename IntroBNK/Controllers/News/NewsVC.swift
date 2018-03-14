//
//  newsViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import Firebase

class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FetchImageDelegate {

  //MARK: - Variables
  private var newsArray = [News]()
  private let newCell = "NewID"
  private let db = Firestore.firestore()
  
  //MARK: - UI Components
  private let loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.activityIndicatorViewStyle = .gray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.startAnimating()
    
    return indicator
  }()
  
  private let refresher: UIRefreshControl = {
    let refresher = UIRefreshControl()
    refresher.tintColor = .gray
    refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
    refresher.attributedTitle = NSAttributedString(string: "Loading...")
    
    return refresher
  }()
  
  //MARK: - Fetch Data
  private func fetchNewsData() {
    db.collection("News").getDocuments { (querySnapshot, err) in
      if let err = err {
        let alert = UIAlertController(title: "พบความผิดพลาด", message: "กรุณาเช็คอินเตอร์เน็ต", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Err: \(err)")
      }
      
      self.newsArray = [News]()
      
      for document in querySnapshot!.documents {
        guard let title = document.data()["title"] as? String else { return }
        guard let place = document.data()["place"] as? String else { return }
        guard let pic = document.data()["pic"] as? String else { return }
        guard let date = document.data()["date"] as? Date else { return }
        
        let news = News(
          id: document.documentID,
          title: title,
          place: place,
          pic: pic,
          date: date
        )
        
        self.newsArray.append(news)
      }
      
      self.newsArray.reverse()
      
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
        self.loading.stopAnimating()
        self.loading.hidesWhenStopped = true
        self.stopRefresher()
      }
      
    }
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupRefresher()
    setupNavigation()
    setupCollectionView()
    setupLoadingIndicator()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    fetchNewsData()
  }
  
  // MARK: - Refresh Function
  @objc private func loadData() {
    fetchNewsData()
  }
  
  private func stopRefresher() {
    refresher.endRefreshing()
  }
  
  // MARK: - Setup UI Functions
  private func setupRefresher() {
    collectionView!.alwaysBounceVertical = true
    collectionView!.addSubview(refresher)
  }
  
  private func setupNavigation() {
    navigationItem.title = "News"
  }
  
  private func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: newCell)
  }
  
  private func setupLoadingIndicator() {
    collectionView?.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: (collectionView?.centerXAnchor)!),
      loading.centerYAnchor.constraint(equalTo: (collectionView?.centerYAnchor)!)
      ])
  }
}

extension NewsVC {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - 48, height: UIScreen.main.bounds.width + 65)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return newsArray.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCell, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
    cell.fetchPictureDelegate = self
    cell.news = newsArray[indexPath.item]
    
    return cell
  }
}
