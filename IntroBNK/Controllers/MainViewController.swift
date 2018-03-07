//
//  ViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 2/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let mainItems = ["News", "Members", "MV"]
  let mainCellIdentifier = "CellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.backgroundColor = .white
    collectionView?.register(MainCell.self, forCellWithReuseIdentifier: mainCellIdentifier)
    navigationItem.title = "BNK48"
  }
  
}

extension MainViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      let layout = UICollectionViewFlowLayout()
      let newsController = NewsViewController(collectionViewLayout: layout)
      navigationController?.pushViewController(newsController, animated: true)
    case 1:
      let layout = UICollectionViewFlowLayout()
      let membersController = MembersViewController(collectionViewLayout: layout)
      layout.minimumLineSpacing = 27
      navigationController?.pushViewController(membersController, animated: true)
    case 2:
      let layout = UICollectionViewFlowLayout()
      let mvController = MVViewController(collectionViewLayout: layout)
      navigationController?.pushViewController(mvController, animated: true)
    default:
      let aleart = UIAlertController(title: "Error!!", message: "Please try again", preferredStyle: .alert)
      aleart.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(aleart, animated: true, completion: nil)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width-40, height: (view.frame.width-40)/2.105)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainItems.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellIdentifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
    cell.mainImage.image = UIImage(named: mainItems[indexPath.row])
    
    return cell
  }
  
}

