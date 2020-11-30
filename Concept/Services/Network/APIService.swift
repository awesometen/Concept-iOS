//
//  APIClient.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import Foundation
import Moya

enum APIService {
  case coupons
  case fetchMenu
  case placeOrder(items: Any)
}

extension APIService: TargetType {
  var baseURL: URL { return URL(string: "https://myapps.api/myservice")! }
  
  var path: String {
    switch self {
    case .coupons:
      return "/coupons/"
    case .fetchMenu:
      return "/fetchMenu/"
    case .placeOrder(_):
      return "/placeOrder"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .coupons, .fetchMenu:
      return .get
    default:
      return .post
    }
  }
  
  var task: Task {
    switch self {
    case .coupons, .fetchMenu:
      return .requestPlain
    case .placeOrder(_):
      return .requestPlain
    }
  }
  
  var sampleData: Data {
    return mockResponse.utf8Encoded
  }
  
  var mockResponse: String {
    switch self {
    case .coupons:
      return String.contentFrom(file: "CouponsListMock") ?? ""
    case .fetchMenu:
      return String.contentFrom(file: "MenuListMock") ?? ""
    case .placeOrder(_):
      return String.contentFrom(file: "PlaceOrderMock") ?? ""
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}

//MARK: Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }

  static func contentFrom(file: String) -> String? {
    var content: String?
    guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return nil }
    do {
      content = try String(contentsOfFile: path, encoding: .utf8)
    } catch {
      return nil
    }
    return content
  }
}
