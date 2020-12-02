//
//  CurrentMenuSubCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit

protocol CurrentMenuSubCollectionViewCellInterface {
  var title: String { get }
  var isSelected: Bool { get }
}

struct CurrentMenuSubCollectionViewCellModel: CurrentMenuSubCollectionViewCellInterface {
  var title: String
  var isSelected: Bool
}

class CurrentMenuSubCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  //MARK: IBOutlet properties
  @IBOutlet private weak var titleLabel: UILabel!
  
  //MARK: Life cycle methods
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  //MARK: Public methods
  func configure(with cellModel: CurrentMenuSubCollectionViewCellInterface) {
    titleLabel.text = cellModel.title
    titleLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
    titleLabel.textColor = cellModel.isSelected ? .black : .lightGray
  }
}
