//
//  API.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 14/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Firebase

class APIService {
  
  static let shared = APIService()
  private let db = Firestore.firestore()

  func getFireStoreData(from collection: String, completionHandler: @escaping ([DocumentSnapshot]) -> ()) {
    db.collection(collection).getDocuments { (querySnapshot, err) in
      if let err = err {
        print("Err: \(err)")
      } else {
        completionHandler(querySnapshot!.documents)
      }
    }
  }
}
