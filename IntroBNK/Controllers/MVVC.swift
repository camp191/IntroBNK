//
//  MVViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  private let cellID = "MVCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    setupCollectionView()
  }
  
  private func setupNavigation() {
    navigationItem.title = "Music Videos"
  }
  
  private func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(MVCell.self, forCellWithReuseIdentifier: cellID)
  }
  
}

extension MVVC {
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let mvVideoViewController = MVVideoVC()
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
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
}