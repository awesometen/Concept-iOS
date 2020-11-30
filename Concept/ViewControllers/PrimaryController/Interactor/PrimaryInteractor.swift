//
//  PrimaryInteractor.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import Foundation
import RxSwift
import Moya

class PrimaryInteractor: PrimaryControllerPresenterToInteractor {
  var presenter: PrimaryControllerInteractorToPresenter?
  
  func fetchData() {
    AppAssembly.shared.provider.reactive.request(.coupons).mapString().start {  [weak self] (event) in
      switch event {
      case .value(let response):
        guard let couponsListModel = CouponListResponse(JSONString: response) else { return }
        self?.presenter?.fetchOfferSuccess(with: couponsListModel)
      case .failed(let error):
        print(error)
      default:
        break
      }
    }
  }
}
