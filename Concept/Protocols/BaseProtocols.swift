//
//  BaseProtocols.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import Foundation
import UIKit
import Pulley

//MARK: General

protocol BaseRouter {
  static var mainstoryboard: UIStoryboard { get }
}

extension BaseRouter {
  static var mainstoryboard: UIStoryboard {
    return UIStoryboard(name:"Main",bundle: Bundle.main)
  }
}

//MARK: Primary Router (Coupons View Controller)

protocol PrimaryControllerViewToPresenter: class {
  var view: PrimaryControllerPresenterToView? { get set }
  var interactor: PrimaryControllerPresenterToInteractor? { get set }
  var router: PrimaryControllerPresenterToRouter? { get set }
  
  func fetchOffersList()
  func presentSecondaryController()
}

protocol PrimaryControllerPresenterToView: class {
  func offerList(array: CouponListResponse)
  func onError(_ error: Error)
}

protocol PrimaryControllerPresenterToRouter: class, BaseRouter {
  static func createModule() -> PrimaryViewController
  func showSecondaryController()
}

protocol PrimaryControllerPresenterToInteractor: class {
  var presenter: PrimaryControllerInteractorToPresenter? { get set }
  func fetchData()
}

protocol PrimaryControllerInteractorToPresenter: class {
  func fetchOfferSuccess(with data: CouponListResponse)
  func fetchOfferFailed(with error:Error)
}


//MARK: Base Router

protocol BaseControllerViewToPresenter: class, BaseViewDelegate {
  var view: BaseControllerPresenterToView? { get set }
  var router: BasePresenterToRouter? { get set }
}

protocol BaseControllerPresenterToView: class {
  func updatePulley(position: PulleyPosition)
  func prepareForFullScreen(with topInsect: CGFloat)
}

protocol BasePresenterToRouter: class {
  func createModule() -> BaseViewController
  func moveSecondaryControllerToFullScreen(_ height: CGFloat)
}

protocol BasePresenterToInteractor: class {
  var presenter: BaseInteractorToPresenter? { get }
}

protocol BaseInteractorToPresenter: class {

}
