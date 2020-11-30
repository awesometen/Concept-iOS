//
//  BaseViewController.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import UIKit
import Pulley

class BaseViewController: PulleyViewController {
  
  //MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundDimmingColor = .orange
    initialDrawerPosition = .partiallyRevealed
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

extension BaseViewController: BaseControllerPresenterToView {
  func updatePulley(position: PulleyPosition) {
    setDrawerPosition(position: .open, animated: true)
  }
  
  func prepareForFullScreen(with topInsect: CGFloat) {
  }
}
