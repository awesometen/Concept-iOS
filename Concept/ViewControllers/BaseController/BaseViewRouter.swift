//
//  BaseViewRouter.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import Pulley

class BaseViewRouter: BasePresenterToRouter {
  
  var presenter: BaseControllerViewToPresenter!
  var viewController: BaseViewController!
  var router: BasePresenterToRouter!
  var primaryController: PrimaryViewController!
  var secondaryController: SecondaryViewController!
  
  func createModule() -> BaseViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    viewController = storyboard.instantiateViewController(withIdentifier: "BaseViewController") as? BaseViewController
    presenter = BaseViewPresenter()
    router = BaseViewRouter()
    presenter.view = viewController
    presenter.router = router
    
    primaryController = PrimaryRouter.createModule()
    secondaryController = SecondaryViewRouter.createModule()
    secondaryController.presenter?.baseDelegate = presenter
    viewController.setPrimaryContentViewController(controller: primaryController)
    viewController.setDrawerContentViewController(controller: secondaryController)
    viewController?.delegate = secondaryController
    viewController.drawerTopInset = -((viewController?.drawerTopInset ?? 0) + 26)
    return viewController 
  }
  
  func moveSecondaryControllerToFullScreen(_ height: CGFloat) {

  }
}
