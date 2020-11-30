//
//  MenuContentCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit

protocol MenuContentCollectionViewCellInterface {
  var menuItems: [MenuItems] { get }
}

struct MenuContentCollectionViewCellModel: MenuContentCollectionViewCellInterface {
  var menuItems: [MenuItems]
}

class MenuContentCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.registerReusableCell(cellType: MenuCollectionSubCollectionViewCell.self)
      collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
  }
  @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
  
  //MARK: Private properties
  private var cellModel: MenuContentCollectionViewCellInterface?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with cellModel: MenuContentCollectionViewCellInterface) {
    self.cellModel = cellModel
    collectionView.reloadData()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionViewHeightConstraint.constant = collectionView.contentSize.height
  }
}


extension MenuContentCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MenuCollectionSubCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
    guard let menu = cellModel?.menuItems[indexPath.section] else { return cell }
    let model = MenuCollectionSubCollectionViewCellModel(menu: menu)
    cell.configure(with: model)
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return cellModel?.menuItems.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 450)
  }
}

