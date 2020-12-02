//
//  SecondaryViewRouter.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import UIKit

class SecondaryViewRouter: SecondaryPresenterToRouter {
  static func createModule() -> SecondaryViewController {
    let viewController = mainstoryboard.instantiateViewController(withIdentifier: Constants.ViewControllers.secondary) as! SecondaryViewController
    let presenter: SecondaryViewPresenter & SecondaryInteractorToPresenter = SecondaryViewPresenter()
    let interactor = SecondaryViewInteractor()
    let router: SecondaryPresenterToRouter = SecondaryViewRouter()
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    viewController.presenter = presenter
    return viewController
  }
  
  func moveToCart() { }
}
