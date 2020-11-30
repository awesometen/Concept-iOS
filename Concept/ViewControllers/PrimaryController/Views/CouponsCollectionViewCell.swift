//
//  CouponsCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit


protocol CouponsCollectionViewModelInterface {
  var title: String { get }
  var subTitle: String { get }
  var imageUrl: String { get }
}

struct CouponsCollectionViewModel: CouponsCollectionViewModelInterface {
  var title: String
  var subTitle: String
  var imageUrl: String
}

class CouponsCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet weak var parentView: UIView!
  @IBOutlet weak var titleLabel: CouptonTitleLabel!
  @IBOutlet weak var subTitleLabel: CouptonSubTitleLabel!
  @IBOutlet weak var thumbView: UIImageView!
  @IBOutlet weak var parentViewWidth: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    parentView.backgroundColor = .red
    parentViewWidth.constant = UIScreen.main.bounds.width
  }
  
  func configure(with model: CouponsCollectionViewModelInterface) {
    titleLabel.text = model.title
    subTitleLabel.text = model.subTitle
  }
}
