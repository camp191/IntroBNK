//
//  MusicVideos.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 11/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Firebase

struct MusicVideo {
  var id: String
  var title: String
  var titleThai: String
  var pic: String
  var link: String
  var date: Date
  
  init(document: DocumentSnapshot) {
    self.id = document.documentID
    self.title = document.data()["title"] as? String ?? "-"
    self.titleThai = document.data()["titleThai"] as? String ?? "-"
    self.pic = document.data()["pic"] as? String ?? ""
    self.link = document.data()["link"] as? String ?? ""
    self.date = document.data()["date"] as? Date ?? Date()
  }
}
