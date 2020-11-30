//
//  AppAssembly.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import Foundation
import Moya

class AppAssembly {
  
  static var shared: AppAssembly = AppAssembly()
  
  private(set) var provider: MoyaProvider<APIService>!
  
  init() {
    let endpointClosure = { (target: APIService) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    let stubClosure = { (target: APIService) -> Moya.StubBehavior in
      return .immediate
    }
    provider = MoyaProvider(endpointClosure: endpointClosure, stubClosure: stubClosure)
  }
}
