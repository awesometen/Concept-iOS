//
//  MenuFiltersSubCollectionViewCell.swift
//  Concept
//
//  Created by awesomej on 29/11/20.
//

import UIKit

protocol MenuFiltersSubCollectionViewCellInterface {
  var title: String { get }
  var isSelected: Bool { get }
}

struct MenuFiltersSubCollectionViewCellModel: MenuFiltersSubCollectionViewCellInterface {
  var title: String
  var isSelected: Bool
}


class MenuFiltersSubCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var filterLabel: BorderedLabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with cellModel: MenuFiltersSubCollectionViewCellInterface) {
    filterLabel.text = cellModel.title
    filterLabel.backgroundColor = cellModel.isSelected ? .blue : filterLabel.backgroundColor
  }
}
