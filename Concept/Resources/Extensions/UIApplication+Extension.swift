//
//  UIApplication+Extension.swift
//  Concept
//
//  Created by awesomej on 29/11/20.
//

import UIKit

extension UIApplication {
  var safeAreaTopPadding: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    } else {
      return 0
    }
  }
  
  var safeAreaBottomPadding: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    } else {
      return 0
    }
  }
}
