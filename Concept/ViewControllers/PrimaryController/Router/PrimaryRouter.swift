//
//  PrimaryRouter.swift
//  Concept
//
//  Created by awesomej on 26/11/20.
//

import UIKit


class PrimaryRouter: PrimaryControllerPresenterToRouter {

  static func createModule() -> PrimaryViewController {
    let viewController = mainstoryboard.instantiateViewController(withIdentifier: Constants.ViewControllers.primary) as! PrimaryViewController
    let presenter: PrimaryControllerViewToPresenter & PrimaryControllerInteractorToPresenter   = PrimaryPresenter()
    let interactor: PrimaryControllerPresenterToInteractor = PrimaryInteractor()
    let router: PrimaryControllerPresenterToRouter = PrimaryRouter()
    viewController.presenter = presenter
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    return viewController
  }

  func showSecondaryController() {
    
  }
  
}
