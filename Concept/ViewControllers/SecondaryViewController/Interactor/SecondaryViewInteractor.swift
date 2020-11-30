//
//  SecondaryViewInteractor.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import Foundation

class SecondaryViewInteractor: SecondaryPresenterToInteractor {
  
  var presenter: SecondaryInteractorToPresenter?
  
  func fetchMenuItems() {
    AppAssembly.shared.provider.reactive.request(.fetchMenu).mapString().start { [weak self] (event) in
      guard let strongSelf = self else { return }
      switch event {
      case .value(let response):
        guard let menuModel = MenuListResponse(JSONString: response) else { return }
        strongSelf.presenter?.fetchMenuItemSuccess(with: menuModel)
      case .failed(let error):
        strongSelf.presenter?.fetchMenuItemFailed(with: error)
      default:
        break
      }
    }
  }
}
