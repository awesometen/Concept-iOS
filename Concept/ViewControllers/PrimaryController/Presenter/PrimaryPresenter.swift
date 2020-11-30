//
//  PrimaryPresenter.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import Foundation

class PrimaryPresenter: PrimaryControllerViewToPresenter {
  var view: PrimaryControllerPresenterToView?
  var interactor: PrimaryControllerPresenterToInteractor?
  var router: PrimaryControllerPresenterToRouter?
  
  
  func fetchOffersList() {
    interactor?.fetchData()
  }
  
  func presentSecondaryController() {
    
  }
}


extension PrimaryPresenter: PrimaryControllerInteractorToPresenter {
  func fetchOfferSuccess(with data: CouponListResponse) {
    view?.offerList(array: data)
  }
  
  func fetchOfferFailed(with error: Error) {
    
  }
}
