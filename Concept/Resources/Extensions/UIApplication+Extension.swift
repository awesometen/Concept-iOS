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

extension UIDevice {
  var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
      return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 > 20
    }
    return false
  }
}
