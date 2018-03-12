//
//  newsViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  private let newCell = "NewID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    setupCollectionView()
  }
  
  private func setupNavigation() {
    navigationItem.title = "News"
  }
  
  private func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: newCell)
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
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCell, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
    
    return cell
  }
}
