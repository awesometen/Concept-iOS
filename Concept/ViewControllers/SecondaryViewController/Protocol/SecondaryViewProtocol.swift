//
//  SecondaryViewProtocol.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import Foundation

protocol SecondaryViewToPresenter: class {
  var view: SecondaryPresenterToView? { get set }
  var interactor: SecondaryPresenterToInteractor? { get set }
  var router: SecondaryPresenterToRouter? { get set }
  var baseDelegate: BaseViewDelegate? { get set }

  func fetchMenuItems()
}

protocol SecondaryPresenterToView: class {
  func fetchedItems(menu: MenuListResponse)
}

protocol SecondaryPresenterToRouter: class, BaseRouter {
  static func createModule() -> SecondaryViewController
  
  func moveToCart()
}

protocol SecondaryPresenterToInteractor: class {
  var presenter: SecondaryInteractorToPresenter? { get set }
  func fetchMenuItems()
}

protocol SecondaryInteractorToPresenter: class {
  func fetchMenuItemSuccess(with items: MenuListResponse)
  func fetchMenuItemFailed(with error: Error)
}
