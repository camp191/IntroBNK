//
//  News.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 12/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Firebase

struct News {
  var id: String
  var title: String
  var place: String
  var pic: String
  var date: Date
  
  init(document: DocumentSnapshot) {
    self.id = document.documentID
    self.title = document.data()["title"] as? String ?? "-"
    self.place = document.data()["place"] as? String ?? "-"
    self.pic = document.data()["pic"] as? String ?? ""
    self.date = document.data()["date"] as? Date ?? Date()
  }
}
