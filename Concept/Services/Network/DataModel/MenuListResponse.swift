//
//  MenuListResponse.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa

struct MenuListResponse: Mappable {
  
  //MARK: Private properties
  private(set) var subMenus: [String]?
  private(set) var foodMenu: [MenuItemModel]?
  
  init?(map: Map) { }
  
  //MARK: Public methods
  mutating func mapping(map: Map) {
    var menuItems: String?
    menuItems <- map["subMenus"]
    foodMenu <- map["foodMenu"]
    subMenus = menuItems?.components(separatedBy: ",")
  }
}

struct MenuItemModel: Mappable {
 
  //MARK: Private properties
  private(set) var category: String?
  private(set) var menuItems: [MenuItems]?
  private(set) var available: Bool?
  
  init?(map: Map) { }
  
  //MARK: Public methods
  mutating func mapping(map: Map) {
    category <- map["category"]
    menuItems <- map["menuItems"]
    available <- map["available"]
  }
}

struct MenuItems: Mappable {
  
  //MARK: Private properties
  private(set) var dishName: String?
  private(set) var receipe: String?
  private(set) var price: Double?
  private(set) var type: String?
  private(set) var thumbnailImage: String?
  
  init?(map: Map) { }
  
  //MARK: Public methods
  mutating func mapping(map: Map) {
    dishName <- map["dishName"]
    receipe <- map["receipe"]
    price <- map["price"]
    type <- map["type"]
    thumbnailImage <- map["thumbnailImage"]
  }
}
