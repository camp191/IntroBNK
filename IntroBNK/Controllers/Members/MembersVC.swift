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
          guard let name = document.data()["name"] as? String else { return }
          guard let nameEng = document.data()["nameEng"] as? String else { return }
          guard let nickname = document.data()["nickname"] as? String else { return }
          guard let picBig = document.data()["picBig"] as? String else { return }
          guard let picSmall = document.data()["picSmall"] as? String else { return }
          guard let province = document.data()["province"] as? String else { return }
          guard let bloodGroup = document.data()["bloodGroup"] as? String else { return }
          guard let dateOfBirth = document.data()["dateOfBirth"] as? Date else { return }
          guard let height = document.data()["height"] as? Int else { return }
          guard let hobby = document.data()["hobby"] as? String else { return }
          guard let like = document.data()["like"] as? String else { return }
          
          let member = Member(
            id: document.documentID,
            name: name,
            nameEng: nameEng,
            nickname: nickname,
            picBig: picBig,
            picSmall: picSmall,
            province: province,
            bloodGroup: bloodGroup,
            dateOfBirth: dateOfBirth,
            height: height,
            hobby: hobby,
            like: like
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
    memberViewController.memberData = members[indexPath.item]
    memberViewController.members = members
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
