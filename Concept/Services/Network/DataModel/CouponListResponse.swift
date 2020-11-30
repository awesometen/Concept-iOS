//
//  CouponListResponse.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import Foundation
import ObjectMapper

struct CouponListResponse: Mappable {
  
  private(set) var expirationDate: String?
  private(set) var areaCode: Int?
  private(set) var coupons: [CouponModel]?
  
  init?(map: Map) { }
  
  mutating func mapping(map: Map) {
    expirationDate <- map["expirationDate"]
    areaCode <- map["areaCode"]
    coupons <- map["coupons"]
  }
}


struct CouponModel: Mappable {
    
  private(set) var title: String?
  private(set) var subTitle: String?
  private(set) var thumbnail: String?
  private(set) var code: String?
  
  init?(map: Map) { }

  mutating func mapping(map: Map) {
    title <- map["title"]
    subTitle <- map["subTitle"]
    thumbnail <- map["thumbnail"]
    code <- map["code"]
  }
}
