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
    
    return refresher
  }()
  
  //MARK: - Fetch Data
  internal func fetchImageData(linkImageString: String, completion: @escaping (Data) -> Void) -> Void {
    if let urlImage = URL(string: linkImageString) {
      let task = URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, res, err) in
        if let err = err {
          print("Failed to retrieve the image: ", err)
          return
        }
        guard let imageData = data else { return }
        completion(imageData)
      })
      task.resume()
    }
  }
  
  private func fetchNewsData() {
    db.collection("News").getDocuments { (querySnapshot, err) in
      if let err = err {
        let alert = UIAlertController(title: "พบความผิดพลาด", message: "กรุณาเช็คอินเตอร์เน็ต", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Err: \(err)")
      }
      
      for document in querySnapshot!.documents {
        let news = News(
          id: document.documentID,
          title: document.data()["title"] as! String,
          place: document.data()["place"] as! String,
          pic: document.data()["pic"] as! String,
          date: document.data()["date"] as! Date
        )
        
        self.newsArray.append(news)
      }
      
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
    
    fetchNewsData()
    setupRefresher()
    setupNavigation()
    setupCollectionView()
    setupLoadingIndicator()
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
    cell.news = newsArray[indexPath.item]
    cell.fetchPictureDelegate = self
    cell.layoutIfNeeded()
    
    return cell
  }
}
