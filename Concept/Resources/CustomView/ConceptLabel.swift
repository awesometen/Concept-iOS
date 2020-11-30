//
//  ConceptLabel.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit

protocol CustomizableViewProtocol {
  func setup()
}

class ConceptLabel: UILabel {
  
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
}

final class CouptonTitleLabel: ConceptLabel {
  override func setup() {
    textColor = .white
    font = UIFont.boldSystemFont(ofSize: 20.0)
  }
}


final class CouptonSubTitleLabel: ConceptLabel {
  override func setup() {
    textColor = .white
    font = UIFont.systemFont(ofSize: 18.0)
  }
}


final class BorderedLabel: ConceptLabel {
  override func setup() {
    textColor = .black
    font = UIFont.systemFont(ofSize: 16.0)
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.cornerRadius = frame.height/2
    
  }
}
