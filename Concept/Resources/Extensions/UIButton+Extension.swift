//
//  UIButton+Extension.swift
//  Concept
//
//  Created by Vijay Jayapal on 30/11/20.
//

import UIKit

class BaseConceptButton: UIButton, CustomizableViewProtocol {
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  func setup() {}
  
  func setFont(size: CGFloat) {}
}

final class BuyButton: BaseConceptButton {
  
  var originalTitle: String?
  
  override func setup() {
    layer.cornerRadius = frame.height / 2
    backgroundColor = .black
    setTitleColor(.white, for: .normal)
    setTitleColor(.white, for: .highlighted)
    addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
  }
  
  override func setFont(size: CGFloat) {
    self.titleLabel?.font = UIFont.systemFont(ofSize: size)
  }
  
  @objc func onTap(_ sender: Any) {
    originalTitle = title(for: .normal)
    setTitle("added +1", for: .normal)
    backgroundColor = .systemGreen
    perform(#selector(revert), with: self, afterDelay: 0.5)
  }
  
  @objc func revert() {
    backgroundColor = .black
    setTitle(originalTitle, for: .normal)
  }
}
