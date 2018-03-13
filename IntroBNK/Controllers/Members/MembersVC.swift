//
//  MembersViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import Firebase

class MembersVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FetchImageDelegate {

  //MARK: - Variables
  private let cellMemberView = "CellID"
  private let db = Firestore.firestore()
  private var members = [Member]()
  
  //MARK: - UI Component
  private let loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.activityIndicatorViewStyle = .gray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    
    return indicator
  }()
  
  //MARK: - Fetch Data
  private func fetchAllMembersData() {
    db.collection("Members").getDocuments { (querySnapshot, err) in
      if let err = err {
        let alert = UIAlertController(title: "พบความผิดพลาด", message: "กรุณาเช็คอินเตอร์เน็ต", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Err: \(err)")
      } else {
        for document in querySnapshot!.documents {
          let member = Member(
            id: document.documentID,
            name: document.data()["name"] as! String,
            nameEng: document.data()["nameEng"] as! String,
            nickname: document.data()["nickname"] as! String,
            picBig: document.data()["picBig"] as! String,
            picSmall: document.data()["picSmall"] as! String,
            province: document.data()["province"] as! String,
            bloodGroup: document.data()["bloodGroup"] as! String,
            dateOfBirth: document.data()["dateOfBirth"] as! Date,
            height: document.data()["height"] as! Int,
            hobby: document.data()["hobby"] as! String,
            like: document.data()["like"] as! String
          )
          self.members.append(member)
          
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.loading.stopAnimating()
          }
        }
      }
    }
  }
  
  internal func fetchImageData(linkImageString: String, completion: @escaping (Data) -> Void) {
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
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLoadingIndicator()
    fetchAllMembersData()
    setupNavigation()
    setupCollectionView()
  }
  
  //MARK: - Setup UI Functions
  private func setupNavigation() {
    navigationItem.title = "Members"
  }
  
  private func setupCollectionView() {
    collectionView?.register(MemberCell.self, forCellWithReuseIdentifier: cellMemberView)
    collectionView?.backgroundColor = .white
  }
  
  private func setupLoadingIndicator() {
    collectionView?.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: (collectionView?.centerXAnchor)!),
      loading.centerYAnchor.constraint(equalTo: (collectionView?.centerYAnchor)!)
      ])
  }
  
}

extension MembersVC {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let layout = UICollectionViewFlowLayout()
    let memberViewController = MemberVC(collectionViewLayout: layout)
    memberViewController.titleName = members[indexPath.item].nickname
    navigationController?.pushViewController(memberViewController, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 18, left: 16, bottom: 18, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width/3) - 20, height: (view.frame.width/3) - 6)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMemberView, for: indexPath) as? MemberCell else { return UICollectionViewCell() }
    cell.delegate = self
    cell.member = members[indexPath.item]
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return members.count
  }
}
