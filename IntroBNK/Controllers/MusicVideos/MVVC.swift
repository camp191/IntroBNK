//
//  MVViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FetchImageDelegate {
  
  //MARK: - Variables
  private var musicVideos = [MusicVideo]()
  private let cellID = "MVCell"
  
  //MARK: - UI Component
  private let loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.activityIndicatorViewStyle = .gray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.startAnimating()
    
    return indicator
  }()
  
  //MARK: - Fetch Data
  func getMVData() {
    APIService.shared.getFireStoreData(from: "MusicVideos") { (queryDocuments) in
      for document in queryDocuments {
        let musicVideo = MusicVideo(document: document)
        self.musicVideos.append(musicVideo)
      }
      
      self.musicVideos.reverse()
      
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
        self.loading.hidesWhenStopped = true
        self.loading.stopAnimating()
      }
    }

  }
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getMVData()
    setupNavigation()
    setupCollectionView()
    setupLoadingIndicator()
  }
  
  //MARK: - Setup UI Function
  private func setupNavigation() {
    navigationItem.title = "Music Videos"
  }
  
  private func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(MVCell.self, forCellWithReuseIdentifier: cellID)
  }
  
  private func setupLoadingIndicator() {
    collectionView?.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: (collectionView?.centerXAnchor)!),
      loading.centerYAnchor.constraint(equalTo: (collectionView?.centerYAnchor)!)
      ])
  }
  
}

extension MVVC {
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let mvVideoViewController = MVVideoVC()
    let musicVideo = musicVideos[indexPath.item]
    mvVideoViewController.mvLink = musicVideo.link
    
    navigationController?.pushViewController(mvVideoViewController, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width-48, height: 85)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MVCell else { return UICollectionViewCell() }
    
    let musicVideo = musicVideos[indexPath.item]
    cell.fetchPictureDelegate = self
    cell.musicVideo = musicVideo
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return musicVideos.count
  }
}
