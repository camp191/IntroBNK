//
//  Members.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 13/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Firebase

struct Member {
  var id: String
  var name: String
  var nameEng: String
  var nickname: String
  var picBig: String
  var picSmall: String
  var province: String
  var bloodGroup: String
  var dateOfBirth: Date
  var height: Int
  var hobby: String
  var like: String
  
  init(document: DocumentSnapshot) {
    self.id = document.documentID
    self.name = document.data()["name"] as? String ?? ""
    self.nameEng = document.data()["nameEng"] as? String ?? ""
    self.nickname = document.data()["nickname"] as? String ?? "-"
    self.picBig = document.data()["picBig"] as? String ?? ""
    self.picSmall = document.data()["picSmall"] as? String ?? ""
    self.province = document.data()["province"] as? String ?? "-"
    self.bloodGroup = document.data()["bloodGroup"] as? String ?? "-"
    self.dateOfBirth = document.data()["dateOfBirth"] as? Date ?? Date()
    self.height = document.data()["height"] as? Int ?? 0
    self.hobby = document.data()["hobby"] as? String ?? "-"
    self.like = document.data()["like"] as? String ?? "-"
  }
}
