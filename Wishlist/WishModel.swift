//
//  WishModel.swift
//  Wishlist
//
//  Created by k21047kk on 2025/01/03.
//

import Foundation
import SwiftData

@Model
class Wish {
  var title: String
  
  init(title: String) {
    self.title = title
  }
}
