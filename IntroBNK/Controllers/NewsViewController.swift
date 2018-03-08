//
//  newsViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let newCell = "NewID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    setupCollectionView()
  }
  
  func setupNavigation() {
    navigationItem.title = "News"
  }
  
  func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: newCell)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCell, for: indexPath)
    
    cell.backgroundColor = . blue
    
    return cell
  }
}
