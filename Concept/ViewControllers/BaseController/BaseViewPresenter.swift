//
//  BaseViewPresenter.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import Pulley

protocol BaseViewDelegate {
  func updatePulley(position: PulleyPosition)
  func prepareForFullScreen(with topInsect: CGFloat)
}

class BaseViewPresenter: BaseControllerViewToPresenter {
  var view: BaseControllerPresenterToView?
  var router: BasePresenterToRouter?
  
  func updatePulley(position: PulleyPosition) {
    view?.updatePulley(position: position)
  }
  
  func prepareForFullScreen(with topInsect: CGFloat) { }
}


