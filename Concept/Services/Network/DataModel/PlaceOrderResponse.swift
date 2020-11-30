//
//  PlaceOrderResponse.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import ObjectMapper

enum OrderPaymentMode: String {
  case cash
  case card
  case applePay
}

struct PlaceOrderResponse: Mappable {
  
  //MARK: Properties
  private(set) var expectedDeliveryTime: String?
  private(set) var trackingDetails: OrderTrackingDetails?
  private(set) var paymentMode: OrderPaymentMode?
  
  init?(map: Map) { }
  
  //MARK: Public methods
  mutating func mapping(map: Map) {
    expectedDeliveryTime <- map["expectedDeliveryTime"]
    trackingDetails <- map["trackingDetails"]
    paymentMode <- map["paymentMode"]
  }
}

struct OrderTrackingDetails: Mappable {
  
  private(set) var latitude: Double?
  private(set) var longitude: Double?
  
  init?(map: Map) { }
  
  //MARK: Public methods
  mutating func mapping(map: Map) {
    latitude <- map["latitude"]
    longitude <- map["longitude"]
  }
}
