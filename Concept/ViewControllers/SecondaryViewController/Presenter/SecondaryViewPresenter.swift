//
//  SecondaryViewPresenter.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import Foundation

class SecondaryViewPresenter: SecondaryViewToPresenter {
  
  var view: SecondaryPresenterToView?
  
  var interactor: SecondaryPresenterToInteractor?
  
  var router: SecondaryPresenterToRouter?
  
  var baseDelegate: BaseViewDelegate?
  
  func fetchMenuItems() {
    interactor?.fetchMenuItems()
  }
}

extension SecondaryViewPresenter: SecondaryInteractorToPresenter {
  func fetchMenuItemSuccess(with items: MenuListResponse) {
    view?.fetchedItems(menu: items)
  }
  
  func fetchMenuItemFailed(with error: Error) {  }
}
