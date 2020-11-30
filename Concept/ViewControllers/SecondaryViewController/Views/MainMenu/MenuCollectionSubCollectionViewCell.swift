//
//  MenuCollectionSubCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit

protocol MenuCollectionSubCollectionViewCellInterface {
  var menu: MenuItems { get }
}

struct MenuCollectionSubCollectionViewCellModel: MenuCollectionSubCollectionViewCellInterface {
  var menu: MenuItems
}

class MenuCollectionSubCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet weak var itemName: UILabel!
  @IBOutlet weak var receipeListLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var thumbnailImage: UIImageView!
  @IBOutlet weak var parentContentView: ShadowedTileView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    thumbnailImage.setCornerRadius(10)
    itemName.font = UIFont.systemFont(ofSize: 24, weight: .black)
  }
  
  func configure(with cellModel: MenuCollectionSubCollectionViewCellInterface) {
    itemName.text = cellModel.menu.dishName
    receipeListLabel.text = cellModel.menu.receipe
    quantityLabel.text = cellModel.menu.price?.description
  }
}
