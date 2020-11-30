//
//  UIView+Extension.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit

extension UIView {
  func setCornerRadius(_ value: CGFloat = 8.0) {
    self.layer.cornerRadius = value
    self.clipsToBounds = true
  }
}


class CustomizableView: UIView {
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  // MARK: - Private methods
  func setupView() { }
}


class ShadowedTileView: CustomizableView {

  //MARK: Private properties
  private let cornerRadiusView = UIView.init(frame: CGRect.zero)

  override func setupView() {
    self.backgroundColor = .clear
    self.clipsToBounds = false
    self.layer.masksToBounds = false
    self.layer.shadowOffset = CGSize(width: 0, height: 3)
    self.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.36, alpha: 0.1).cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 4.0

    cornerRadiusView.backgroundColor = .white
    cornerRadiusView.setCornerRadius()
    self.addSubview(cornerRadiusView)

    cornerRadiusView.translatesAutoresizingMaskIntoConstraints = false
    self.trailingAnchor.constraint(equalTo: cornerRadiusView.trailingAnchor, constant: 0.0).isActive = true
    self.leadingAnchor.constraint(equalTo: cornerRadiusView.leadingAnchor, constant: 0.0).isActive = true
    self.topAnchor.constraint(equalTo: cornerRadiusView.topAnchor, constant: 0.0).isActive = true
    self.bottomAnchor.constraint(equalTo: cornerRadiusView.bottomAnchor, constant: 0.0).isActive = true
    self.sendSubviewToBack(cornerRadiusView)
  }
}
